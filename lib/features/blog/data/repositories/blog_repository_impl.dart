import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';
import 'package:weblog/core/network/connection_checker.dart';
import 'package:weblog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:weblog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:weblog/features/blog/data/models/blog_model.dart';
import 'package:weblog/features/blog/domain/entities/blog.dart';
import 'package:weblog/features/blog/domain/repository/blog_repositroy.dart';
import 'package:weblog/core/error/exceptions.dart';
import 'package:weblog/core/error/failure.dart';

class BlogRepositoryImpl implements BlogRepositroy {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final BlogLocalDataSource blogLocalDataSource;

  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.connectionChecker,
    required this.blogLocalDataSource
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String posterId,
    required String content,
    required List<String> topics,
  }) async {
    try {
       if (!await connectionChecker.isConnected) {
      return left(Failure("No Internet connection"));
    }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
   try {
    if (!await connectionChecker.isConnected) {
      final blogs = blogLocalDataSource.loadBlogs();
      return right(blogs);
    }
     final blogs = await blogRemoteDataSource.getAllBlogs();
     blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
     return right(blogs);
   }on ServerException catch (e) {
     return Left(Failure(e.message));
   }
  }
}
