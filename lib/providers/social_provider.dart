import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';

final socialFeedProvider =
    StateNotifierProvider<SocialFeedNotifier, AsyncValue<List<PostModel>>>((ref) {
  return SocialFeedNotifier();
});

class SocialFeedNotifier extends StateNotifier<AsyncValue<List<PostModel>>> {
  SocialFeedNotifier() : super(const AsyncValue.loading()) {
    loadFeed();
  }

  int _page = 1;
  bool _hasMore = true;

  Future<void> loadFeed({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      state = const AsyncValue.loading();
    }

    try {
      // Mock data - replace with actual API call
      await Future.delayed(const Duration(milliseconds: 800));
      final posts = _getMockPosts();

      if (refresh || _page == 1) {
        state = AsyncValue.data(posts);
      } else {
        state = AsyncValue.data([...state.value ?? [], ...posts]);
      }
      _page++;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;
    await loadFeed();
  }

  Future<void> likePost(String postId) async {
    final posts = state.value;
    if (posts == null) return;

    final index = posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final post = posts[index];
    final updatedPost = post.copyWith(
      isLiked: !post.isLiked,
      likesCount: post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
    );

    final updatedPosts = [...posts];
    updatedPosts[index] = updatedPost;
    state = AsyncValue.data(updatedPosts);

    // TODO: Call API to persist like
  }

  Future<void> createPost({
    required String content,
    List<String> imageUrls = const [],
    String? videoUrl,
    List<String> tags = const [],
  }) async {
    // TODO: Call API to create post
    await Future.delayed(const Duration(milliseconds: 500));
    // Refresh feed after posting
    await loadFeed(refresh: true);
  }

  List<PostModel> _getMockPosts() {
    return [
      PostModel(
        id: 'post_001',
        authorId: 'user_001',
        authorName: '星驰车主小王',
        content: '刚刚提车了！全新星驰SUV真的太香了，续航600公里，动力十足！#星驰 #新能源 #提车日记',
        imageUrls: [
          'https://picsum.photos/seed/car1/800/600',
          'https://picsum.photos/seed/car2/800/600',
        ],
        tags: ['星驰', '新能源', '提车日记'],
        likesCount: 128,
        commentsCount: 34,
        sharesCount: 12,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      PostModel(
        id: 'post_002',
        authorId: 'user_002',
        authorName: '汽车爱好者',
        content: '分享一下星驰的驾驶体验，悬挂调校非常舒适，噪音控制做得很好。城市通勤完全够用！',
        tags: ['驾驶体验', '星驰'],
        likesCount: 86,
        commentsCount: 22,
        sharesCount: 8,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];
  }
}
