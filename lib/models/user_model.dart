class UserModel {
  final String id;
  final String nickname;
  final String? avatar;
  final String? phone;
  final String? email;
  final String? bio;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final String? token;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.nickname,
    this.avatar,
    this.phone,
    this.email,
    this.bio,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.token,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        nickname: json['nickname'] as String,
        avatar: json['avatar'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        bio: json['bio'] as String?,
        followersCount: (json['followers_count'] as int?) ?? 0,
        followingCount: (json['following_count'] as int?) ?? 0,
        postsCount: (json['posts_count'] as int?) ?? 0,
        token: json['token'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nickname': nickname,
        'avatar': avatar,
        'phone': phone,
        'email': email,
        'bio': bio,
        'followers_count': followersCount,
        'following_count': followingCount,
        'posts_count': postsCount,
        'token': token,
        'created_at': createdAt.toIso8601String(),
      };

  UserModel copyWith({
    String? id,
    String? nickname,
    String? avatar,
    String? phone,
    String? email,
    String? bio,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    String? token,
    DateTime? createdAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        bio: bio ?? this.bio,
        followersCount: followersCount ?? this.followersCount,
        followingCount: followingCount ?? this.followingCount,
        postsCount: postsCount ?? this.postsCount,
        token: token ?? this.token,
        createdAt: createdAt ?? this.createdAt,
      );
}
