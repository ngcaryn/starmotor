import 'package:flutter/material.dart';
import 'package:starmotor/models/service_model.dart';
import 'package:starmotor/screens/service/booking_screen.dart';

class ServiceHomeScreen extends StatelessWidget {
  const ServiceHomeScreen({super.key});

  static final _services = [
    ServiceModel(
        id: 's001', name: '常规保养', iconName: 'build', price: 399, estimatedDurationMinutes: 90),
    ServiceModel(
        id: 's002', name: '轮胎服务', iconName: 'tire_repair', price: 0, estimatedDurationMinutes: 60),
    ServiceModel(
        id: 's003', name: '外观修复', iconName: 'auto_fix_high', price: 0, estimatedDurationMinutes: 120),
    ServiceModel(
        id: 's004', name: '软件升级', iconName: 'system_update', price: 0, estimatedDurationMinutes: 30),
    ServiceModel(
        id: 's005', name: '空调检修', iconName: 'air', price: 199, estimatedDurationMinutes: 60),
    ServiceModel(
        id: 's006', name: '电池检测', iconName: 'battery_full', price: 0, estimatedDurationMinutes: 45),
  ];

  static const _faqs = [
    {'q': '保养周期是多久？', 'a': '建议每12个月或每行驶20,000公里进行一次常规保养，以较早发生者为准。'},
    {'q': '如何预约上门取送车服务？', 'a': '您可以在预约界面选择"上门取送车"选项，我们的服务顾问将联系确认时间。'},
    {'q': '质保政策是什么？', 'a': '整车质保5年或15万公里，电池及驱动系统质保8年或16万公里。'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('服务')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: const Text('服务项目',
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return _ServiceCard(
                  service: service,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          BookingScreen(service: service),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // Warranty info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.verified_user, color: Colors.green),
                  title: const Text('质保服务'),
                  subtitle: const Text('整车5年/电池8年质保'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => const _WarrantySheet(),
                  ),
                ),
              ),
            ),
            // FAQs
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('常见问题',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ..._faqs.map((faq) => ExpansionTile(
                  title: Text(faq['q']!),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: Text(faq['a']!),
                    ),
                  ],
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const _ServiceCard({required this.service, required this.onTap});

  IconData get _icon {
    switch (service.iconName) {
      case 'tire_repair':
        return Icons.tire_repair;
      case 'auto_fix_high':
        return Icons.auto_fix_high;
      case 'system_update':
        return Icons.system_update;
      case 'air':
        return Icons.air;
      case 'battery_full':
        return Icons.battery_full;
      default:
        return Icons.build;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(service.name,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _WarrantySheet extends StatelessWidget {
  const _WarrantySheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('质保说明',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('• 整车质保：5年或15万公里'),
          Text('• 电池及电机：8年或16万公里'),
          Text('• 车身钣金防锈：10年'),
          Text('• 免费道路救援：5年不限次数'),
          SizedBox(height: 16),
          Text('详细条款请查阅随车文件或联系客服。',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
