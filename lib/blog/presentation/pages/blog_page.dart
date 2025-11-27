import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/blog/presentation/bloc/blog_bloc.dart';
import 'package:weblog/blog/presentation/pages/add_new_blog_page.dart';
import 'package:weblog/blog/presentation/widgets/blog_card.dart';
import 'package:weblog/core/common/widgets/loader.dart';
import 'package:weblog/core/theme/app_pallete.dart';
import 'package:weblog/core/utils/show_snakbar.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  void initState() {
    
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }
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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnakbar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsDisplaySuccess) {
             return ListView.builder(
              itemCount: state.blogs.length   ,
            itemBuilder: (context,index){
              final blog = state.blogs[index];   
              return BlogCard(blog: blog, color:index % 3 == 0 ? AppPallete.gradient1 : index % 3 == 1? AppPallete.gradient2 : Colors.black45);
            });
          }
         return SizedBox();
        },
      ),
    );
  }
}
