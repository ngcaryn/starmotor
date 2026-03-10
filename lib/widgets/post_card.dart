import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../config/theme_config.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
    this.onLike,
    this.onComment,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author header
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: post.authorAvatarUrl != null
                        ? NetworkImage(post.authorAvatarUrl!)
                        : null,
                    backgroundColor: AppColors.primary.withAlpha(30),
                    child: post.authorAvatarUrl == null
                        ? Text(
                            post.authorName.isNotEmpty ? post.authorName[0] : '?',
                            style: const TextStyle(color: AppColors.primary),
                          )
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.authorName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            if (post.isOfficial) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.verified,
                                  size: 14, color: AppColors.primary),
                            ],
                          ],
                        ),
                        Text(
                          _timeAgo(post.createdAt),
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.grey500),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: AppColors.grey500),
                    onPressed: () {},
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Content
              Text(
                post.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),

              // Images
              if (post.imageUrls.isNotEmpty) ...[
                const SizedBox(height: 10),
                _PostImages(imageUrls: post.imageUrls),
              ],

              // Tags
              if (post.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: post.tags
                      .take(3)
                      .map((tag) => Text(
                            '#$tag',
                            style: const TextStyle(
                                color: AppColors.info, fontSize: 12),
                          ))
                      .toList(),
                ),
              ],

              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 8),

              // Actions
              Row(
                children: [
                  _ActionButton(
                    icon: post.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    label: '${post.likesCount}',
                    color: post.isLiked ? AppColors.accent : AppColors.grey500,
                    onTap: onLike ?? () {},
                  ),
                  const SizedBox(width: 20),
                  _ActionButton(
                    icon: Icons.comment_outlined,
                    label: '${post.commentsCount}',
                    color: AppColors.grey500,
                    onTap: onComment ?? () {},
                  ),
                  const SizedBox(width: 20),
                  _ActionButton(
                    icon: Icons.share_outlined,
                    label: '${post.sharesCount}',
                    color: AppColors.grey500,
                    onTap: onShare ?? () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
    if (diff.inHours < 24) return '${diff.inHours}小时前';
    if (diff.inDays < 7) return '${diff.inDays}天前';
    return '${date.month}月${date.day}日';
  }
}

class _PostImages extends StatelessWidget {
  final List<String> imageUrls;

  const _PostImages({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (imageUrls.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrls[0],
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Container(height: 200, color: AppColors.grey200),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: imageUrls.length == 2 ? 2 : 3,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      childAspectRatio: 1,
      children: imageUrls.take(9).map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: AppColors.grey200),
          ),
        );
      }).toList(),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}
