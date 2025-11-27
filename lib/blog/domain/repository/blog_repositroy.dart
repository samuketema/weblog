import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:weblog/blog/domain/entities/blog.dart';
import 'package:weblog/core/error/failure.dart';

abstract interface class BlogRepositroy { 
  Future<Either<Failure,Blog>> uploadBlog({
    required File image,
    required String title,
    required String posterId,
    required String content,
    required List<String> topics
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}