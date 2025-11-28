import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/features/blog/domain/entities/blog.dart';
import 'package:weblog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:weblog/features/blog/domain/usecases/upload_blog.dart';
import 'package:weblog/core/usecase/usecase.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
    : _uploadBlog = uploadBlog,
      _getAllBlogs = getAllBlogs,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>((event, emit) async {
      final res = await _uploadBlog(
        UploadBlogParams(
          title: event.title,
          posterId: event.posterId,
          content: event.content,
          image: event.image,
          topics: event.topics,
        ),
      );
      res.fold(
        (l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogUploadSuccess()),
      );
    });
    on<BlogFetchAllBlogs>((event, emit) async {
      final res = await _getAllBlogs(NoParams());
      res.fold(
        (l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogsDisplaySuccess(blogs: r)),
      );
    });
  }
}
