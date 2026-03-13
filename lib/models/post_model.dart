class CommentModel {
  final String id;
  final String postId;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final String content;
  final int likesCount;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.content,
    this.likesCount = 0,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'] as String,
        postId: json['post_id'] as String,
        authorId: json['author_id'] as String,
        authorName: json['author_name'] as String,
        authorAvatar: json['author_avatar'] as String?,
        content: json['content'] as String,
        likesCount: (json['likes_count'] as int?) ?? 0,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'post_id': postId,
        'author_id': authorId,
        'author_name': authorName,
        'author_avatar': authorAvatar,
        'content': content,
        'likes_count': likesCount,
        'created_at': createdAt.toIso8601String(),
      };
}

class PostModel {
  final String id;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final String content;
  final List<String> images;
  final List<String> tags;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isLiked;
  final DateTime createdAt;

  const PostModel({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.content,
    this.images = const [],
    this.tags = const [],
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.isLiked = false,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as String,
        authorId: json['author_id'] as String,
        authorName: json['author_name'] as String,
        authorAvatar: json['author_avatar'] as String?,
        content: json['content'] as String,
        images: List<String>.from(json['images'] as List? ?? []),
        tags: List<String>.from(json['tags'] as List? ?? []),
        likesCount: (json['likes_count'] as int?) ?? 0,
        commentsCount: (json['comments_count'] as int?) ?? 0,
        sharesCount: (json['shares_count'] as int?) ?? 0,
        isLiked: (json['is_liked'] as bool?) ?? false,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'author_id': authorId,
        'author_name': authorName,
        'author_avatar': authorAvatar,
        'content': content,
        'images': images,
        'tags': tags,
        'likes_count': likesCount,
        'comments_count': commentsCount,
        'shares_count': sharesCount,
        'is_liked': isLiked,
        'created_at': createdAt.toIso8601String(),
      };

  PostModel copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    String? content,
    List<String>? images,
    List<String>? tags,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    bool? isLiked,
    DateTime? createdAt,
  }) =>
      PostModel(
        id: id ?? this.id,
        authorId: authorId ?? this.authorId,
        authorName: authorName ?? this.authorName,
        authorAvatar: authorAvatar ?? this.authorAvatar,
        content: content ?? this.content,
        images: images ?? this.images,
        tags: tags ?? this.tags,
        likesCount: likesCount ?? this.likesCount,
        commentsCount: commentsCount ?? this.commentsCount,
        sharesCount: sharesCount ?? this.sharesCount,
        isLiked: isLiked ?? this.isLiked,
        createdAt: createdAt ?? this.createdAt,
      );
}
