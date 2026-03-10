import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../../models/car_model.dart';
import 'configurator_screen.dart';

class CarDetailScreen extends StatefulWidget {
  final CarModel car;

  const CarDetailScreen({super.key, required this.car});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: car.imageUrls.isNotEmpty
                  ? PageView.builder(
                      itemCount: car.imageUrls.length,
                      onPageChanged: (i) =>
                          setState(() => _currentImageIndex = i),
                      itemBuilder: (_, i) => Image.network(
                        car.imageUrls[i],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.grey200,
                          child: const Icon(Icons.directions_car, size: 80),
                        ),
                      ),
                    )
                  : Container(
                      color: AppColors.grey200,
                      child: const Icon(Icons.directions_car, size: 80),
                    ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
              IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car.nameChinese,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              car.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '¥${(car.basePrice / 10000).toStringAsFixed(1)}万起',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: AppColors.accent),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Highlights
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: car.highlights
                        .map((h) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withAlpha(15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                h,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: '车型参数'),
                Tab(text: '配色选择'),
                Tab(text: '版本对比'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _SpecsTab(specs: car.specs, fuelType: car.fuelType),
                  _ColorsTab(colors: car.availableColors),
                  _VariantsTab(variants: car.variants),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfiguratorScreen(car: car),
                        ),
                      );
                    },
                    child: const Text('开始配置'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Book test drive
                    },
                    child: const Text('预约试驾'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecsTab extends StatelessWidget {
  final CarSpecs specs;
  final String fuelType;

  const _SpecsTab({required this.specs, required this.fuelType});

  @override
  Widget build(BuildContext context) {
    final items = <_SpecItem>[];
    if (specs.range != null) {
      items.add(_SpecItem(label: '续航里程', value: '${specs.range!.toInt()}km'));
    }
    if (specs.horsepower != null) {
      items.add(_SpecItem(label: '最大功率', value: '${specs.horsepower}hp'));
    }
    if (specs.acceleration != null) {
      items.add(_SpecItem(label: '百公里加速', value: '${specs.acceleration}s'));
    }
    if (specs.topSpeed != null) {
      items.add(_SpecItem(label: '最高车速', value: '${specs.topSpeed!.toInt()}km/h'));
    }
    if (specs.seats != null) {
      items.add(_SpecItem(label: '座位数', value: '${specs.seats}座'));
    }
    if (specs.driveType != null) {
      items.add(_SpecItem(label: '驱动方式', value: specs.driveType!));
    }
    if (specs.batteryCapacity != null) {
      items.add(_SpecItem(label: '电池容量', value: '${specs.batteryCapacity}kWh'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(items[i].label,
                style: const TextStyle(color: AppColors.grey500)),
            Text(items[i].value,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _SpecItem {
  final String label;
  final String value;
  const _SpecItem({required this.label, required this.value});
}

class _ColorsTab extends StatefulWidget {
  final List<CarColor> colors;
  const _ColorsTab({required this.colors});

  @override
  State<_ColorsTab> createState() => _ColorsTabState();
}

class _ColorsTabState extends State<_ColorsTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.colors.isEmpty) {
      return const Center(child: Text('暂无配色信息'));
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          widget.colors[_selectedIndex].nameChinese,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.colors.asMap().entries.map((entry) {
            final i = entry.key;
            final color = entry.value;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = i),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(color.colorHex),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _selectedIndex == i
                        ? AppColors.primary
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (widget.colors[_selectedIndex].additionalPrice != null) ...[
          const SizedBox(height: 12),
          Text(
            '+¥${widget.colors[_selectedIndex].additionalPrice!.toInt()}',
            style: const TextStyle(color: AppColors.accent),
          ),
        ],
      ],
    );
  }
}

class _VariantsTab extends StatelessWidget {
  final List<CarVariant> variants;
  const _VariantsTab({required this.variants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: variants.length,
      itemBuilder: (_, i) {
        final variant = variants[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      variant.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(
                      '¥${(variant.price / 10000).toStringAsFixed(1)}万',
                      style: const TextStyle(
                          color: AppColors.accent, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...variant.features
                    .map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.check,
                                  size: 16, color: AppColors.success),
                              const SizedBox(width: 8),
                              Text(f, style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ))
                    ,
              ],
            ),
          ),
        );
      },
    );
  }
}
