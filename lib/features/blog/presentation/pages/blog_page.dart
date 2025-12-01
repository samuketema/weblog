import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:weblog/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:weblog/features/blog/presentation/widgets/blog_card.dart';
import 'package:weblog/core/common/widgets/loader.dart';
import 'package:weblog/core/theme/app_pallete.dart';
import 'package:weblog/core/utils/show_snakbar.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
    
    // Optional: Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !_isLoading) {
      // Implement pagination if needed
      // context.read<BlogBloc>().add(BlogFetchMoreBlogs());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _refreshBlogs() {
    setState(() {
      _isLoading = true;
    });
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundLight,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppPallete.mainGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.article_rounded,
                color: AppPallete.whiteColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Weblog",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppPallete.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(AddNewBlogPage.route());
              },
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppPallete.mainGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: AppPallete.whiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: AppPallete.backgroundLight,
        color: AppPallete.gradient1,
        onRefresh: () async {
          _refreshBlogs();
        },
        child: BlocConsumer<BlogBloc, BlogState>(
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
              if (state.blogs.isEmpty) {
                return _buildEmptyState();
              }
              return _buildBlogList(state);
            }
            return _buildErrorState();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(AddNewBlogPage.route());
        },
        backgroundColor: AppPallete.gradient1,
        foregroundColor: AppPallete.whiteColor,
        elevation: 4,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildBlogList(BlogsDisplaySuccess state) {
    return Column(
      children: [
        // Header Stats
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppPallete.backgroundLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppPallete.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    state.blogs.length.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.gradient1,
                    ),
                  ),
                  Text(
                    'Total Blogs',
                    style: TextStyle(
                      color: AppPallete.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                height: 30,
                width: 1,
                color: AppPallete.borderColor,
              ),
              Column(
                children: [
                  Text(
                    '${state.blogs.length}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.gradient2,
                    ),
                  ),
                  Text(
                    'Active',
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
        
        // Blog List
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: state.blogs.length,
            itemBuilder: (context, index) {
              final blog = state.blogs[index];
              final colorIndex = index % 3;
              final Color cardColor;
              
              switch (colorIndex) {
                case 0:
                  cardColor = AppPallete.gradient1;
                case 1:
                  cardColor = AppPallete.gradient2;
                case 2:
                  cardColor = AppPallete.gradient3;
                default:
                  cardColor = AppPallete.gradient1;
              }
              
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: BlogCard(
                  blog: blog,
                  color: cardColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppPallete.backgroundLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppPallete.borderColor),
                ),
                child: Icon(
                  Icons.article_rounded,
                  size: 80,
                  color: AppPallete.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No Blogs Yet',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Start sharing your thoughts and experiences\nwith the community',
                style: TextStyle(
                  fontSize: 16,
                  color: AppPallete.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(AddNewBlogPage.route());
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text('Create Your First Blog'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPallete.gradient1,
                  foregroundColor: AppPallete.whiteColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: AppPallete.errorColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppPallete.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please pull down to refresh',
            style: TextStyle(
              color: AppPallete.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _refreshBlogs,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.gradient1,
              foregroundColor: AppPallete.whiteColor,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}