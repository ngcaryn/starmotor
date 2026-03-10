import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme_config.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import 'settings_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authNotifierProvider);

    return Scaffold(
      body: userState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('请登录'));
          }

          return CustomScrollView(
            slivers: [
              // Profile header
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryLight],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 36,
                                  backgroundImage: user.avatarUrl != null
                                      ? NetworkImage(user.avatarUrl!)
                                      : null,
                                  child: user.avatarUrl == null
                                      ? Text(
                                          user.nickname[0],
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            user.nickname,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (user.isVerified) ...[
                                            const SizedBox(width: 4),
                                            const Icon(Icons.verified,
                                                color: Colors.white, size: 18),
                                          ],
                                        ],
                                      ),
                                      if (user.phone != null)
                                        Text(
                                          user.phone!.replaceRange(3, 7, '****'),
                                          style: const TextStyle(
                                              color: Colors.white60,
                                              fontSize: 13),
                                        ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                  onPressed: () {
                                    // TODO: Open edit profile
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _StatItem(
                                    count: user.postsCount, label: '帖子'),
                                const SizedBox(width: 24),
                                _StatItem(
                                    count: user.followingCount, label: '关注'),
                                const SizedBox(width: 24),
                                _StatItem(
                                    count: user.followersCount, label: '粉丝'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings_outlined,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // My orders section
                    _SectionCard(
                      title: '我的订单',
                      trailing: TextButton(
                        onPressed: () {
                          // TODO: Go to all orders
                        },
                        child: const Text('查看全部'),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _OrderStatusItem(
                              icon: Icons.payment, label: '待付款'),
                          _OrderStatusItem(
                              icon: Icons.local_shipping, label: '待发货'),
                          _OrderStatusItem(
                              icon: Icons.inventory_2, label: '待收货'),
                          _OrderStatusItem(
                              icon: Icons.star_rate, label: '待评价'),
                          _OrderStatusItem(
                              icon: Icons.assignment_return, label: '退换货'),
                        ],
                      ),
                    ),

                    // My services section
                    _SectionCard(
                      title: '我的服务',
                      child: Column(
                        children: const [
                          _MenuListTile(
                            icon: Icons.directions_car,
                            title: '我的爱车',
                            iconColor: AppColors.primary,
                          ),
                          _MenuListTile(
                            icon: Icons.favorite_border,
                            title: '我的收藏',
                            iconColor: AppColors.accent,
                          ),
                          _MenuListTile(
                            icon: Icons.location_on_outlined,
                            title: '收货地址',
                            iconColor: AppColors.info,
                          ),
                          _MenuListTile(
                            icon: Icons.card_giftcard,
                            title: '优惠券',
                            iconColor: AppColors.warning,
                          ),
                        ],
                      ),
                    ),

                    // Other section
                    _SectionCard(
                      title: '其他',
                      child: Column(
                        children: [
                          _MenuListTile(
                            icon: Icons.help_outline,
                            title: '帮助中心',
                            iconColor: AppColors.grey500,
                          ),
                          _MenuListTile(
                            icon: Icons.info_outline,
                            title: '关于星驰',
                            iconColor: AppColors.grey500,
                          ),
                          ListTile(
                            leading: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.error.withAlpha(20),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.logout,
                                  color: AppColors.error, size: 20),
                            ),
                            title: const Text('退出登录',
                                style: TextStyle(color: AppColors.error)),
                            onTap: () => _confirmLogout(context, ref),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('加载失败')),
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('退出登录'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authNotifierProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('退出'),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final int count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const _SectionCard({required this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
            child: Row(
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                const Spacer(),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _OrderStatusItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OrderStatusItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColors.grey700),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.grey500)),
        ],
      ),
    );
  }
}

class _MenuListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;

  const _MenuListTile({
    required this.icon,
    required this.title,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: AppColors.grey300),
      onTap: () {
        // TODO: Navigate to respective screen
      },
    );
  }
}
