import 'package:hive/hive.dart';
import 'package:weblog/features/blog/data/models/blog_model.dart';

abstract class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl({required this.box});

  @override
  List<BlogModel> loadBlogs() {
    final List<BlogModel> blogs = [];

    // Iterate over all keys in the box
    for (var key in box.keys) {
      final data = box.get(key);
      if (data != null) {
        blogs.add(BlogModel.fromJson(Map<String, dynamic>.from(data)));
      }
    }

    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    // Clear existing data
    box.clear();

    // Store each blog with a string key (like '0', '1', '2', ...)
    for (var i = 0; i < blogs.length; i++) {
      box.put(i.toString(), blogs[i].toJson());
    }
  }
}
