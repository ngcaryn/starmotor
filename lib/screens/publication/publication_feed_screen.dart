import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../../models/post_model.dart';
import '../../widgets/post_card.dart';

class PublicationFeedScreen extends StatelessWidget {
  const PublicationFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('官方发布'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '全部'),
              Tab(text: '新闻'),
              Tab(text: '活动'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _PublicationList(publications: _getMockPublications()),
            _PublicationList(
              publications: _getMockPublications()
                  .where((p) => !p.tags.contains('活动'))
                  .toList(),
            ),
            _PublicationList(
              publications: _getMockPublications()
                  .where((p) => p.tags.contains('活动'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<PostModel> _getMockPublications() {
    return [
      PostModel(
        id: 'pub_001',
        authorId: 'official',
        authorName: '星驰官方',
        content: '【重磅发布】星驰S7正式上市！续航620km，配备最新L2+智能辅助驾驶系统，现已开启全国预订。',
        imageUrls: ['https://picsum.photos/seed/pub1/800/400'],
        tags: ['新车发布', '星驰S7'],
        likesCount: 3248,
        commentsCount: 512,
        isOfficial: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      PostModel(
        id: 'pub_002',
        authorId: 'official',
        authorName: '星驰官方',
        content: '【活动预告】2024星驰品牌体验日即将开启！全国18个城市同步举办，欢迎莅临体验最新车型。',
        imageUrls: ['https://picsum.photos/seed/pub2/800/400'],
        tags: ['活动', '品牌体验'],
        likesCount: 1876,
        commentsCount: 234,
        isOfficial: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PostModel(
        id: 'pub_003',
        authorId: 'official',
        authorName: '星驰官方',
        content: '星驰荣获2024年度最佳新能源汽车品牌大奖，感谢每一位星驰车主的支持与信任！',
        imageUrls: ['https://picsum.photos/seed/pub3/800/400'],
        tags: ['品牌新闻', '荣誉'],
        likesCount: 5632,
        commentsCount: 789,
        isOfficial: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }
}

class _PublicationList extends StatelessWidget {
  final List<PostModel> publications;

  const _PublicationList({required this.publications});

  @override
  Widget build(BuildContext context) {
    if (publications.isEmpty) {
      return const Center(
        child: Text('暂无内容', style: TextStyle(color: AppColors.grey500)),
      );
    }
    return ListView.builder(
      itemCount: publications.length,
      itemBuilder: (ctx, i) => PostCard(
        post: publications[i],
        onTap: () {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (_) => PublicationDetailScreen(post: publications[i]),
            ),
          );
        },
        onLike: () {},
      ),
    );
  }
}

class PublicationDetailScreen extends StatelessWidget {
  final PostModel post;

  const PublicationDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('官方发布'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.imageUrls.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.imageUrls.first,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: AppColors.grey200,
                    child: const Icon(Icons.image, size: 48),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.verified, color: AppColors.primary, size: 18),
                const SizedBox(width: 4),
                Text(
                  post.authorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDate(post.createdAt),
                  style: const TextStyle(color: AppColors.grey500, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post.content,
              style: const TextStyle(fontSize: 16, height: 1.7),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: post.tags
                  .map((tag) => Chip(
                        label: Text('#$tag'),
                        backgroundColor: AppColors.primary.withAlpha(15),
                        labelStyle: const TextStyle(color: AppColors.primary),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
