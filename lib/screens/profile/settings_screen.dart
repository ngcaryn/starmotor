import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme_config.dart';
import '../../providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          _SettingsSection(
            title: '账户',
            items: [
              _SettingItem(
                icon: Icons.person_outline,
                title: '个人信息',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.lock_outline,
                title: '账号安全',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.notifications_outlined,
                title: '通知设置',
                onTap: () {},
              ),
            ],
          ),
          _SettingsSection(
            title: '偏好',
            items: [
              _SettingItem(
                icon: Icons.language,
                title: '语言',
                value: '简体中文',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.dark_mode_outlined,
                title: '主题',
                value: '跟随系统',
                onTap: () {},
              ),
            ],
          ),
          _SettingsSection(
            title: '关于',
            items: [
              _SettingItem(
                icon: Icons.info_outline,
                title: '版本',
                value: '1.0.0',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.privacy_tip_outlined,
                title: '隐私政策',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.description_outlined,
                title: '用户协议',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.star_rate_outlined,
                title: '给我们评分',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () => _confirmLogout(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('退出登录'),
            ),
          ),
          const SizedBox(height: 32),
        ],
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
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('退出'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<_SettingItem> items;

  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.grey500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: items.map((item) => _SettingsTile(item: item)).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    this.value,
    required this.onTap,
  });
}

class _SettingsTile extends StatelessWidget {
  final _SettingItem item;

  const _SettingsTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon, size: 22, color: AppColors.grey700),
      title: Text(item.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.value != null)
            Text(item.value!,
                style: const TextStyle(color: AppColors.grey500, fontSize: 13)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: AppColors.grey300),
        ],
      ),
      onTap: item.onTap,
    );
  }
}
