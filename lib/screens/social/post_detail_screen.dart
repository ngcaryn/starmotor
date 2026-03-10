import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../config/theme_config.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('帖子详情'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Share post
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: post.authorAvatarUrl != null
                        ? NetworkImage(post.authorAvatarUrl!)
                        : null,
                    child: post.authorAvatarUrl == null
                        ? Text(post.authorName[0])
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _formatDate(post.createdAt),
                          style: const TextStyle(
                            color: AppColors.grey500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Follow user
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(80, 32),
                    ),
                    child: const Text('关注'),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post.content,
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
            // Images
            if (post.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemCount: post.imageUrls.length,
                  itemBuilder: (_, i) => Image.network(
                    post.imageUrls[i],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.grey200,
                      child: const Icon(Icons.image, size: 48),
                    ),
                  ),
                ),
              ),
            ],
            // Tags
            if (post.tags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8,
                  children: post.tags
                      .map((tag) => Chip(
                            label: Text('#$tag'),
                            backgroundColor: AppColors.primary.withAlpha(20),
                            labelStyle: const TextStyle(color: AppColors.primary),
                          ))
                      .toList(),
                ),
              ),
            // Stats
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _StatChip(
                    icon: Icons.favorite_border,
                    count: post.likesCount,
                    label: '点赞',
                  ),
                  const SizedBox(width: 24),
                  _StatChip(
                    icon: Icons.comment_outlined,
                    count: post.commentsCount,
                    label: '评论',
                  ),
                  const SizedBox(width: 24),
                  _StatChip(
                    icon: Icons.share_outlined,
                    count: post.sharesCount,
                    label: '分享',
                  ),
                ],
              ),
            ),
            const Divider(),
            // Comments section
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '评论',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('暂无评论，来抢沙发吧！', style: TextStyle(color: AppColors.grey500)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _CommentInput(postId: post.id),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
    if (diff.inHours < 24) return '${diff.inHours}小时前';
    return '${diff.inDays}天前';
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;

  const _StatChip({required this.icon, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.grey500),
        const SizedBox(width: 4),
        Text('$count $label', style: const TextStyle(color: AppColors.grey500)),
      ],
    );
  }
}

class _CommentInput extends StatelessWidget {
  final String postId;

  const _CommentInput({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.grey200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: '写下你的评论...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.primary),
            onPressed: () {
              // TODO: Send comment
            },
          ),
        ],
      ),
    );
  }
}
