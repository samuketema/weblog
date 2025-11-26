import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:weblog/blog/domain/entities/blog.dart';
import 'package:weblog/blog/domain/repository/blog_repositroy.dart';
import 'package:weblog/core/error/failure.dart';
import 'package:weblog/core/usecase/usecase.dart';

class UploadBlog implements Usecase<Blog,UploadBlogParams> {
  final BlogRepositroy blogRepositroy;

  UploadBlog({required this.blogRepositroy});
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async{
   return await blogRepositroy.uploadBlog(image: params.image, title: params.title, posterId: params.posterId, content: params.content, topics: params.topics);
  }
  
}

class UploadBlogParams {
  final String title;
  final String posterId;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.title,
    required this.posterId,
    required this.content,
    required this.image,
    required this.topics,
  });
}
