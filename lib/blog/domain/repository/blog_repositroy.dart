import 'package:fpdart/fpdart.dart';
import 'package:weblog/blog/domain/entities/blog.dart';
import 'package:weblog/core/error/failure.dart';

abstract interface class BlogRepositroy {
  Future<Either<Failure,Blog>> uploadBlog();
}