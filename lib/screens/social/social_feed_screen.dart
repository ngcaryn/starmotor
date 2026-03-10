import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/social_provider.dart';
import '../../widgets/post_card.dart';
import '../../widgets/custom_app_bar.dart';
import 'create_post_screen.dart';
import 'post_detail_screen.dart';

class SocialFeedScreen extends ConsumerWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(socialFeedProvider);

    return Scaffold(
      appBar: StarAppBar(
        title: '社区',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Open search
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: feedState.when(
        data: (posts) => RefreshIndicator(
          onRefresh: () => ref
              .read(socialFeedProvider.notifier)
              .loadFeed(refresh: true),
          child: posts.isEmpty
              ? const _EmptyFeed()
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (ctx, i) => PostCard(
                    post: posts[i],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostDetailScreen(post: posts[i]),
                        ),
                      );
                    },
                    onLike: () {
                      ref
                          .read(socialFeedProvider.notifier)
                          .likePost(posts[i].id);
                    },
                  ),
                ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('加载失败: $e'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref
                    .read(socialFeedProvider.notifier)
                    .loadFeed(refresh: true),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('暂无内容，快来发第一条帖子吧！'),
        ],
      ),
    );
  }
}
