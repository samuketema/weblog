import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weblog/blog/presentation/pages/add_new_blog_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App  "),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(AddNewBlogPage.route());
          }, icon: Icon(CupertinoIcons.add_circled)),
        ],
      ),
    );
  }
}
