import 'package:weblog/features/blog/domain/entities/blog.dart';
import 'package:weblog/features/blog/domain/repository/blog_repositroy.dart';
import 'package:weblog/core/error/failure.dart';
import 'package:weblog/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>,NoParams> {
  final BlogRepositroy blogRepositroy;

  GetAllBlogs({required this.blogRepositroy});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async{
   return  await blogRepositroy.getAllBlogs();
  }
  
}