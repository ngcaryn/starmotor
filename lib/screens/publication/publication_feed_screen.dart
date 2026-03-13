import 'package:flutter/material.dart';

class ArticleModel {
  final String id;
  final String title;
  final String summary;
  final String? imageUrl;
  final String type; // 'news' | 'event'
  final DateTime publishedAt;

  const ArticleModel({
    required this.id,
    required this.title,
    required this.summary,
    this.imageUrl,
    required this.type,
    required this.publishedAt,
  });
}

final _mockArticles = [
  ArticleModel(
    id: 'a001',
    title: '星驰L9荣获2024年度家庭用车大奖',
    summary: '在近日举办的中国汽车年度评选中，星驰L9凭借出色的家庭使用体验，斩获年度最佳家庭用车大奖。',
    imageUrl: 'https://picsum.photos/seed/award/600/300',
    type: 'news',
    publishedAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  ArticleModel(
    id: 'a002',
    title: '星驰全国试驾活动开启报名',
    summary: '即日起，全国50城同步开启星驰L9/L8试驾活动，名额有限，先到先得。',
    imageUrl: 'https://picsum.photos/seed/event/600/300',
    type: 'event',
    publishedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  ArticleModel(
    id: 'a003',
    title: '星驰OTA 4.0正式推送，新增多项智驾功能',
    summary: '最新OTA更新带来NOA城市版、自动泊车2.0等多项功能升级，即日起向全系车型推送。',
    type: 'news',
    publishedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
];

class PublicationFeedScreen extends StatefulWidget {
  const PublicationFeedScreen({super.key});

  @override
  State<PublicationFeedScreen> createState() => _PublicationFeedScreenState();
}

class _PublicationFeedScreenState extends State<PublicationFeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('资讯'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '新闻'),
            Tab(text: '活动'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ArticleList(articles:
              _mockArticles.where((a) => a.type == 'news').toList()),
          _ArticleList(articles:
              _mockArticles.where((a) => a.type == 'event').toList()),
        ],
      ),
    );
  }
}

class _ArticleList extends StatelessWidget {
  final List<ArticleModel> articles;

  const _ArticleList({required this.articles});

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const Center(child: Text('暂无内容'));
    }
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.imageUrl != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        article.imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          article.summary,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
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
    );
  }
}
