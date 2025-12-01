import 'package:flutter/material.dart';
import 'package:weblog/features/blog/domain/entities/blog.dart';
import 'package:weblog/core/theme/app_pallete.dart';
import 'package:weblog/core/utils/calculate_reading_time.dart';
import 'package:weblog/core/utils/format_date.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final Blog blog;

  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppPallete.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppPallete.borderColor),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppPallete.textPrimary,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppPallete.backgroundLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppPallete.borderColor),
              ),
              child: Icon(
                Icons.bookmark_border_rounded,
                color: AppPallete.textPrimary,
                size: 20,
              ),
            ),
            onPressed: () {
              // Add bookmark functionality
            },
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppPallete.backgroundLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppPallete.borderColor),
              ),
              child: Icon(
                Icons.share_rounded,
                color: AppPallete.textPrimary,
                size: 20,
              ),
            ),
            onPressed: () {
              // Add share functionality
            },
          ),
        ],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 4,
        radius: const Radius.circular(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Section
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
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
              ),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Section
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppPallete.backgroundLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppPallete.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog.title,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppPallete.textPrimary,
                              height: 1.3,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Author and Meta Information
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: AppPallete.mainGradient,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person_rounded,
                                  color: AppPallete.whiteColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      blog.posterName ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppPallete.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.schedule_rounded,
                                          size: 14,
                                          color: AppPallete.textSecondary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${calculateReadingTime(blog.content)} min read',
                                          style: TextStyle(
                                            color: AppPallete.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Icon(
                                          Icons.calendar_today_rounded,
                                          size: 14,
                                          color: AppPallete.textSecondary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          formatDateByDMMMYYYY(blog.updatedAt),
                                          style: TextStyle(
                                            color: AppPallete.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Topics Section
                    if (blog.topics.isNotEmpty) ...[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: blog.topics.map((topic) {
                            return Container(
                              margin: const EdgeInsets.only(
                                right: 8,
                                bottom: 16,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppPallete.mainGradient,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                topic,
                                style: TextStyle(
                                  color: AppPallete.whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],

                    // Content Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppPallete.backgroundLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppPallete.borderColor),
                      ),
                      child: Text(
                        blog.content,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.8,
                          color: AppPallete.textPrimary,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),

                    // Footer Section
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppPallete.backgroundLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppPallete.borderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: AppPallete.mainGradient,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_rounded,
                              color: AppPallete.whiteColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Written by ${blog.posterName}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppPallete.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Published on ${formatDateByDMMMYYYY(blog.updatedAt)}',
                                  style: TextStyle(
                                    color: AppPallete.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Add follow functionality
                            },
                            icon: Icon(
                              Icons.favorite_border_rounded,
                              color: AppPallete.gradient2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button for Quick Actions
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add quick action (bookmark, share, etc.)
        },
        backgroundColor: AppPallete.gradient1,
        foregroundColor: AppPallete.whiteColor,
        child: const Icon(Icons.bookmark_rounded),
      ),
    );
  }
}
