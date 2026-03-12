import 'package:flutter/material.dart';
import 'package:starmotor/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onTap;
  final VoidCallback? onLike;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author row
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: post.authorAvatar != null
                        ? NetworkImage(post.authorAvatar!)
                        : null,
                    child: post.authorAvatar == null
                        ? Text(post.authorName[0])
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                      Text(
                        _formatDate(post.createdAt),
                        style: const TextStyle(
                            fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Content
              Text(
                post.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              // Image grid
              if (post.images.isNotEmpty) ...[
                const SizedBox(height: 8),
                _ImageGrid(images: post.images),
              ],
              // Tags
              if (post.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: post.tags
                      .map((tag) => Text(
                            '#$tag',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 12),
                          ))
                      .toList(),
                ),
              ],
              const Divider(height: 16),
              // Actions
              Row(
                children: [
                  _ActionChip(
                    icon: post.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    label: '${post.likesCount}',
                    color: post.isLiked ? Colors.red : null,
                    onTap: onLike,
                  ),
                  const SizedBox(width: 16),
                  _ActionChip(
                    icon: Icons.comment_outlined,
                    label: '${post.commentsCount}',
                    onTap: onTap,
                  ),
                  const SizedBox(width: 16),
                  _ActionChip(
                    icon: Icons.share_outlined,
                    label: '${post.sharesCount}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
    if (diff.inHours < 24) return '${diff.inHours}小时前';
    return '${diff.inDays}天前';
  }
}

class _ImageGrid extends StatelessWidget {
  final List<String> images;

  const _ImageGrid({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          images[0],
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      );
    }
    return GridView.count(
      crossAxisCount: images.length <= 4 ? 2 : 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: images
          .take(9)
          .map((url) => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(url, fit: BoxFit.cover),
              ))
          .toList(),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const _ActionChip(
      {required this.icon, required this.label, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color ?? Colors.grey),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 12, color: color ?? Colors.grey)),
        ],
      ),
    );
  }
}
