import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weblog/features/blog/domain/entities/blog.dart';
import 'package:weblog/core/theme/app_pallete.dart';
import 'package:weblog/core/utils/calculate_reading_time.dart';
import 'package:weblog/core/utils/format_date.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final Blog blog;
  BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 20),
                Text(
                  'by ${blog.posterName}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formatDateByDMMMYYYY(blog.updatedAt)} .  ${calculateReadingTime(blog.content)} min',
                  style: TextStyle(
                    color: AppPallete.greyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Show a placeholder when the network image fails
                      return Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 50),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 5),
                Text('${blog.content}', style: TextStyle(height: 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
