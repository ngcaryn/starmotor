import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/providers/auth_provider.dart';
import 'package:starmotor/providers/user_provider.dart';
import 'package:starmotor/screens/profile/settings_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProfileNotifierProvider);
    final ordersState = ref.watch(userOrdersProvider);

    return Scaffold(
      body: userState.when(
        data: (user) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(user?.nickname ?? '未登录'),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: user?.avatar != null
                            ? NetworkImage(user!.avatar!)
                            : null,
                        child: user?.avatar == null
                            ? Text(
                                user?.nickname.isNotEmpty == true
                                    ? user!.nickname[0]
                                    : '?',
                                style: const TextStyle(fontSize: 24),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SettingsScreen()),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Follow stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(
                            label: '帖子',
                            count: user?.postsCount ?? 0),
                        _StatItem(
                            label: '关注',
                            count: user?.followingCount ?? 0),
                        _StatItem(
                            label: '粉丝',
                            count: user?.followersCount ?? 0),
                      ],
                    ),
                    if (user?.bio != null) ...[
                      const SizedBox(height: 12),
                      Text(user!.bio!),
                    ],
                    const SizedBox(height: 24),
                    const Text('我的订单',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    // Order status row
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        _OrderStatusItem(
                            icon: Icons.access_time,
                            label: '待付款'),
                        _OrderStatusItem(
                            icon: Icons.local_shipping_outlined,
                            label: '待发货'),
                        _OrderStatusItem(
                            icon: Icons.inventory_outlined,
                            label: '待收货'),
                        _OrderStatusItem(
                            icon: Icons.rate_review_outlined,
                            label: '待评价'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('订单记录',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ordersState.when(
                      data: (orders) => Column(
                        children: orders
                            .map((o) => Card(
                                  child: ListTile(
                                    title: Text(
                                        '订单 #${o.id.substring(0, 8)}'),
                                    subtitle: Text(o.statusLabel),
                                    trailing: Text(
                                        '¥${o.totalAmount.toStringAsFixed(2)}'),
                                  ),
                                ))
                            .toList(),
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (e, _) => Text('加载失败：$e'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败：$e')),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;

  const _StatItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _OrderStatusItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OrderStatusItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
