import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      return emit(BlogLoading());
    });
    on<BlogUpload>((event, emit) async {
      final res = await uploadBlog(
        UploadBlogParams(
          title: event.title,
          posterId: event.posterId,
          content: event.content,
          image: event.image,
          topics: event.topics,
        ),
      );
     res.fold(
      (l)=> emit(BlogFailure(error: l.message)) ,
      (r)=> emit(BlogSuccess()));
    });
  }
}
