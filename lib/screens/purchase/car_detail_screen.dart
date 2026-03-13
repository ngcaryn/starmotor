import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/models/car_model.dart';
import 'package:starmotor/providers/purchase_provider.dart';
import 'package:starmotor/screens/purchase/configurator_screen.dart';

class CarDetailScreen extends ConsumerWidget {
  final CarModel car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(car.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: '概览'),
              Tab(text: '规格'),
              Tab(text: '颜色'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _OverviewTab(car: car),
            _SpecsTab(car: car),
            _ColorsTab(car: car),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfiguratorScreen(car: car),
                ),
              ),
              child: const Text('立即配置'),
            ),
          ),
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  final CarModel car;
  const _OverviewTab({required this.car});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (car.coverImage != null)
            Image.network(car.coverImage!,
                width: double.infinity, height: 220, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(car.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                if (car.tagline != null) ...[
                  const SizedBox(height: 4),
                  Text(car.tagline!,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
                const SizedBox(height: 8),
                Text(
                  '参考售价 ¥${(car.startingPrice / 10000).toStringAsFixed(1)}万起',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w600),
                ),
                if (car.highlights.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text('核心亮点',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...car.highlights.map((h) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.green, size: 16),
                            const SizedBox(width: 8),
                            Text(h),
                          ],
                        ),
                      )),
                ],
                const SizedBox(height: 16),
                const Text('版本选择',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...car.variants.map((v) => Card(
                      child: ListTile(
                        title: Text(v.name),
                        subtitle: Text('续航 ${v.range}'),
                        trailing: Text(
                          '¥${(v.price / 10000).toStringAsFixed(1)}万',
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecsTab extends StatelessWidget {
  final CarModel car;
  const _SpecsTab({required this.car});

  @override
  Widget build(BuildContext context) {
    final specs = car.specs;
    if (specs == null) {
      return const Center(child: Text('暂无规格信息'));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SpecRow(label: '长度', value: specs.length),
        _SpecRow(label: '宽度', value: specs.width),
        _SpecRow(label: '高度', value: specs.height),
        _SpecRow(label: '轴距', value: specs.wheelbase),
        _SpecRow(label: '座位数', value: specs.seats),
        _SpecRow(label: '驱动方式', value: specs.driveType),
        _SpecRow(label: '电池容量', value: specs.batteryCapacity),
      ],
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  const _SpecRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label,
                style:
                    const TextStyle(color: Colors.grey)),
          ),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _ColorsTab extends StatefulWidget {
  final CarModel car;
  const _ColorsTab({required this.car});

  @override
  State<_ColorsTab> createState() => _ColorsTabState();
}

class _ColorsTabState extends State<_ColorsTab> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.car.colors.asMap().entries.map((e) {
              final i = e.key;
              final c = e.value;
              return GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(c.colorValue),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selected == i
                              ? Colors.blue
                              : Colors.grey.shade300,
                          width: _selected == i ? 3 : 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(c.name, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          if (widget.car.colors.isNotEmpty)
            Text(
              '已选：${widget.car.colors[_selected].name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
