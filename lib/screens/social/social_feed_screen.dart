import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/providers/social_provider.dart';
import 'package:starmotor/screens/social/post_detail_screen.dart';
import 'package:starmotor/screens/social/create_post_screen.dart';
import 'package:starmotor/widgets/post_card.dart';

class SocialFeedScreen extends ConsumerWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(socialFeedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('社区'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: feedState.when(
        data: (posts) => RefreshIndicator(
          onRefresh: () =>
              ref.read(socialFeedProvider.notifier).refresh(),
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(
                post: post,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostDetailScreen(post: post),
                  ),
                ),
                onLike: () =>
                    ref.read(socialFeedProvider.notifier).toggleLike(post.id),
              );
            },
          ),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败：$e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreatePostScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
