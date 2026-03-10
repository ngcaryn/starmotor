import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class ServiceHomeScreen extends StatelessWidget {
  const ServiceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      _ServiceOption(
        icon: Icons.build_outlined,
        title: '保养预约',
        subtitle: '定期保养，延长车辆寿命',
        color: AppColors.primary,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BookingScreen()),
          );
        },
      ),
      _ServiceOption(
        icon: Icons.car_repair,
        title: '维修服务',
        subtitle: '专业维修，恢复最佳状态',
        color: AppColors.info,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BookingScreen()),
          );
        },
      ),
      _ServiceOption(
        icon: Icons.verified_outlined,
        title: '质保信息',
        subtitle: '查看您的车辆质保范围',
        color: AppColors.success,
        onTap: () {
          _showWarrantyInfo(context);
        },
      ),
      _ServiceOption(
        icon: Icons.support_agent,
        title: '在线客服',
        subtitle: '7×24小时专属服务',
        color: AppColors.warning,
        onTap: () {
          // TODO: Open live chat
        },
      ),
      _ServiceOption(
        icon: Icons.location_on_outlined,
        title: '服务中心',
        subtitle: '查找附近的服务网点',
        color: AppColors.accent,
        onTap: () {
          // TODO: Open service center map
        },
      ),
      _ServiceOption(
        icon: Icons.history,
        title: '服务记录',
        subtitle: '查看历史维修保养记录',
        color: AppColors.serviceColor,
        onTap: () {
          // TODO: Show service history
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('服务')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency contact banner
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '紧急道路救援',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          '400-888-0000',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Call emergency number
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      minimumSize: const Size(80, 36),
                    ),
                    child: const Text('呼叫'),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '服务项目',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 12),

            // Service grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: services
                    .map((s) => _ServiceCard(service: s))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            // FAQ section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '常见问题',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            _FaqSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showWarrantyInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '质保信息',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _WarrantyItem(title: '整车质保', duration: '3年/12万公里'),
            _WarrantyItem(title: '动力总成', duration: '5年/20万公里'),
            _WarrantyItem(title: '电池质保', duration: '8年/16万公里'),
            _WarrantyItem(title: '车身生锈', duration: '6年不限公里'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _WarrantyItem extends StatelessWidget {
  final String title;
  final String duration;

  const _WarrantyItem({required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            duration,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _ServiceOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ServiceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceOption service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: service.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(service.icon, color: service.color, size: 28),
            const SizedBox(height: 8),
            Text(
              service.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 2),
            Text(
              service.subtitle,
              style: const TextStyle(fontSize: 11, color: AppColors.grey500),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqSection extends StatelessWidget {
  static const _faqs = [
    _Faq(q: '新车首保需要多少公里？', a: '建议在5000公里或6个月内进行首次保养，以确保车辆处于最佳状态。'),
    _Faq(q: '电动车充电多久能充满？', a: '使用快充桩约需30分钟充至80%，慢充通常需要8-10小时充满。'),
    _Faq(q: '如何预约上门服务？', a: '您可以通过APP预约上门服务，我们的专业团队将在约定时间上门为您服务。'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _faqs
          .map((faq) => ExpansionTile(
                title: Text(
                  faq.q,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        faq.a,
                        style: const TextStyle(
                            color: AppColors.grey700, fontSize: 13, height: 1.6),
                      ),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}

class _Faq {
  final String q;
  final String a;
  const _Faq({required this.q, required this.a});
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _currentStep = 0;
  String? _selectedServiceType;
  String? _selectedCenter;
  DateTime? _selectedDate;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('预约服务')),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep++);
          } else {
            _submitBooking();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        steps: [
          Step(
            title: const Text('选择服务'),
            content: _buildSelectServiceStep(),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('选择门店'),
            content: _buildSelectCenterStep(),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('确认预约'),
            content: _buildConfirmStep(),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectServiceStep() {
    final serviceTypes = [
      ('常规保养', Icons.build),
      ('大保养', Icons.settings),
      ('车辆检测', Icons.search),
      ('故障维修', Icons.car_repair),
    ];

    return Column(
      children: serviceTypes
          .map((s) => RadioListTile<String>(
                title: Text(s.$1),
                value: s.$1,
                groupValue: _selectedServiceType,
                onChanged: (val) => setState(() => _selectedServiceType = val),
                secondary: Icon(s.$2),
              ))
          .toList(),
    );
  }

  Widget _buildSelectCenterStep() {
    final centers = ['星驰朝阳服务中心', '星驰海淀服务中心', '星驰丰台服务中心'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...centers.map(
          (c) => RadioListTile<String>(
            title: Text(c),
            value: c,
            groupValue: _selectedCenter,
            onChanged: (val) => setState(() => _selectedCenter = val),
          ),
        ),
        const SizedBox(height: 12),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: Text(
            _selectedDate != null
                ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
                : '选择预约时间',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 1)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            );
            if (date != null) setState(() => _selectedDate = date);
          },
        ),
      ],
    );
  }

  Widget _buildConfirmStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ConfirmItem(label: '服务类型', value: _selectedServiceType ?? '-'),
        _ConfirmItem(label: '服务中心', value: _selectedCenter ?? '-'),
        _ConfirmItem(
          label: '预约时间',
          value: _selectedDate != null
              ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
              : '-',
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _notesController,
          decoration: const InputDecoration(
            labelText: '备注（选填）',
            hintText: '描述问题或特殊要求',
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  void _submitBooking() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('预约成功！我们将发短信确认您的预约。')),
    );
    Navigator.pop(context);
  }
}

class _ConfirmItem extends StatelessWidget {
  final String label;
  final String value;

  const _ConfirmItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.grey500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
