import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:weblog/features/blog/presentation/pages/blog_page.dart';
import 'package:weblog/features/blog/presentation/widgets/blog_editor.dart';
import 'package:weblog/core/common/app_user/cubit/app_user_cubit.dart';
import 'package:weblog/core/common/widgets/loader.dart';
import 'package:weblog/core/theme/app_pallete.dart';
import 'package:weblog/core/utils/image_picker.dart';
import 'package:weblog/core/utils/show_snakbar.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundLight,
        elevation: 0,
        title: Text(
          'Create New Blog',
          style: TextStyle(
            color: AppPallete.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    selectedTopics.isNotEmpty &&
                    image != null) {
                  final posterId =
                      (context.read<AppUserCubit>().state as AppUserLoggedIn)
                          .user
                          .id;
                  context.read<BlogBloc>().add(
                    BlogUpload(
                      title: titleController.text.trim(),
                      posterId: posterId,
                      content: contentController.text.trim(),
                      image: image!,
                      topics: selectedTopics,
                    ),
                  );
                } else {
                  _showValidationError();
                }
              },
              icon: const Icon(Icons.done_rounded, size: 20),
              label: const Text('Publish'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.gradient1,
                foregroundColor: AppPallete.whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnakbar(context, state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const BlogPage()),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Share Your Story',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create an engaging blog post with images and topics',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppPallete.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Image Upload Section
                    Text(
                      'Featured Image *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppPallete.borderColor,
                                  width: 2,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.black54,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.edit_rounded,
                                            color: AppPallete.whiteColor,
                                            size: 30,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Change Image',
                                            style: TextStyle(
                                              color: AppPallete.whiteColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                              options: RectDottedBorderOptions(
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: AppPallete.borderColor,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: AppPallete.backgroundLight,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_rounded,
                                      size: 50,
                                      color: AppPallete.textSecondary,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Upload Featured Image",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppPallete.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Recommended: 1200x630 pixels",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppPallete.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),

                    // Topics Section
                    Text(
                      'Topics *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Technology',
                          'Business',
                          'Programming',
                          'Entertainment',
                          'Lifestyle',
                          'Education',
                        ]
                            .map(
                              (topic) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: FilterChip(
                                  label: Text(
                                    topic,
                                    style: TextStyle(
                                      color: selectedTopics.contains(topic)
                                          ? AppPallete.whiteColor
                                          : AppPallete.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  selected: selectedTopics.contains(topic),
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedTopics.add(topic);
                                      } else {
                                        selectedTopics.remove(topic);
                                      }
                                    });
                                  },
                                  backgroundColor: AppPallete.backgroundLight,
                                  selectedColor: AppPallete.gradient1,
                                  checkmarkColor: AppPallete.whiteColor,
                                  side: BorderSide(
                                    color: selectedTopics.contains(topic)
                                        ? AppPallete.gradient1
                                        : AppPallete.borderColor,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    if (selectedTopics.isEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Please select at least one topic',
                        style: TextStyle(
                          color: AppPallete.errorColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const SizedBox(height: 30),

                    // Title Section
                    Text(
                      'Blog Title *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlogEditor(
                      controller: titleController,
                      hint: "Enter a captivating title...",
                    ),
                    const SizedBox(height: 25),

                    // Content Section
                    Text(
                      'Blog Content *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlogEditor(
                      controller: contentController,
                      hint: "Write your amazing story here...",
                  
                    ),
                    const SizedBox(height: 40),

                    // Validation Summary
                    if (image == null || selectedTopics.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppPallete.backgroundLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppPallete.borderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: AppPallete.warningColor,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Please make sure to:\n${image == null ? '• Upload a featured image\n' : ''}${selectedTopics.isEmpty ? '• Select at least one topic' : ''}',
                                style: TextStyle(
                                  color: AppPallete.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showValidationError() {
    String message = 'Please complete all required fields:';
    if (image == null) message += '\n• Upload a featured image';
    if (selectedTopics.isEmpty) message += '\n• Select at least one topic';
    
    showSnakbar(context, message);
  }
}