import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/models/post_model.dart';

// Mock social feed data
List<PostModel> _mockPosts() => [
      PostModel(
        id: 'post_001',
        authorId: 'user_001',
        authorName: '车迷小明',
        content: '今天提到了新车，感觉太棒了！星驰L9真的值得！',
        images: [
          'https://picsum.photos/seed/car1/400/300',
          'https://picsum.photos/seed/car2/400/300',
        ],
        tags: ['星驰L9', '新车提车', '电动车'],
        likesCount: 128,
        commentsCount: 32,
        sharesCount: 10,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      PostModel(
        id: 'post_002',
        authorId: 'user_002',
        authorName: '电车达人',
        content: '续航实测：高速跑了400公里，电量还剩18%，非常满意的结果！',
        tags: ['续航测试', '高速'],
        likesCount: 256,
        commentsCount: 78,
        sharesCount: 45,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      PostModel(
        id: 'post_003',
        authorId: 'user_003',
        authorName: '家庭用车',
        content: '带着全家自驾游，后排空间超大，孩子睡了一路😴',
        images: ['https://picsum.photos/seed/family/400/300'],
        tags: ['家庭用车', '自驾游'],
        likesCount: 89,
        commentsCount: 15,
        sharesCount: 5,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

class SocialFeedNotifier extends StateNotifier<AsyncValue<List<PostModel>>> {
  SocialFeedNotifier() : super(const AsyncValue.loading()) {
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      state = AsyncValue.data(_mockPosts());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadFeed();

  void toggleLike(String postId) {
    state.whenData((posts) {
      state = AsyncValue.data([
        for (final p in posts)
          if (p.id == postId)
            p.copyWith(
              isLiked: !p.isLiked,
              likesCount: p.isLiked ? p.likesCount - 1 : p.likesCount + 1,
            )
          else
            p,
      ]);
    });
  }
}

final socialFeedProvider =
    StateNotifierProvider<SocialFeedNotifier, AsyncValue<List<PostModel>>>(
        (ref) => SocialFeedNotifier());
