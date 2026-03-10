import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class BrandStoryScreen extends StatelessWidget {
  const BrandStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('探索品牌'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: '品牌故事'),
              Tab(text: '活动日历'),
              Tab(text: '展厅门店'),
              Tab(text: '品牌画廊'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _BrandStoryTab(),
            _EventsTab(),
            _ShowroomsTab(),
            _GalleryTab(),
          ],
        ),
      ),
    );
  }
}

class _BrandStoryTab extends StatelessWidget {
  const _BrandStoryTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero image
          Image.network(
            'https://picsum.photos/seed/brand_hero/800/400',
            height: 240,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 240,
              color: AppColors.primary,
              child: const Center(
                child: Icon(Icons.directions_car, size: 80, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '星驰汽车的故事',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                const Text(
                  '星驰汽车成立于2019年，是一家专注于新能源智能汽车的科技公司。我们以"让每个家庭都拥有一辆智能电动车"为使命，不断探索汽车与科技的融合边界。',
                  style: TextStyle(fontSize: 15, height: 1.8, color: AppColors.grey700),
                ),
                const SizedBox(height: 16),
                const Text(
                  '我们的愿景是成为中国最受信赖的新能源汽车品牌，通过持续的技术创新，为用户提供安全、智能、愉悦的出行体验。',
                  style: TextStyle(fontSize: 15, height: 1.8, color: AppColors.grey700),
                ),
                const SizedBox(height: 24),
                _MilestoneSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MilestoneSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final milestones = [
      _Milestone(year: '2019', text: '星驰汽车正式成立'),
      _Milestone(year: '2021', text: '首款量产车型发布'),
      _Milestone(year: '2022', text: '累计交付突破10万辆'),
      _Milestone(year: '2023', text: '全国服务中心突破100家'),
      _Milestone(year: '2024', text: '星驰S7旗舰SUV震撼上市'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('品牌历程', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ...milestones.map(
          (m) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    m.year,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(m.text,
                      style: const TextStyle(fontSize: 14, height: 1.6)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Milestone {
  final String year;
  final String text;
  const _Milestone({required this.year, required this.text});
}

class _EventsTab extends StatelessWidget {
  const _EventsTab();

  @override
  Widget build(BuildContext context) {
    final events = [
      _EventItem(
        title: '2024星驰品牌体验日',
        date: '2024-06-15',
        location: '全国18城同步',
        imageUrl: 'https://picsum.photos/seed/event1/400/200',
      ),
      _EventItem(
        title: '星驰科技开放日',
        date: '2024-07-20',
        location: '上海星驰总部',
        imageUrl: 'https://picsum.photos/seed/event2/400/200',
      ),
      _EventItem(
        title: '星驰车主年度嘉年华',
        date: '2024-09-10',
        location: '北京奥林匹克公园',
        imageUrl: 'https://picsum.photos/seed/event3/400/200',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (_, i) => Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                events[i].imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 160,
                  color: AppColors.grey200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(events[i].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 14, color: AppColors.grey500),
                      const SizedBox(width: 4),
                      Text(events[i].date,
                          style: const TextStyle(color: AppColors.grey500)),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on,
                          size: 14, color: AppColors.grey500),
                      const SizedBox(width: 4),
                      Text(events[i].location,
                          style: const TextStyle(color: AppColors.grey500)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventItem {
  final String title;
  final String date;
  final String location;
  final String imageUrl;
  const _EventItem({
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
  });
}

class _ShowroomsTab extends StatelessWidget {
  const _ShowroomsTab();

  @override
  Widget build(BuildContext context) {
    final showrooms = [
      _ShowroomItem(city: '北京', name: '星驰朝阳体验中心', address: '北京市朝阳区建国路100号'),
      _ShowroomItem(city: '上海', name: '星驰浦东旗舰店', address: '上海市浦东新区陆家嘴环路1000号'),
      _ShowroomItem(city: '广州', name: '星驰天河体验中心', address: '广州市天河区天河路385号'),
      _ShowroomItem(city: '深圳', name: '星驰南山旗舰店', address: '深圳市南山区科技园南区'),
      _ShowroomItem(city: '成都', name: '星驰锦江体验中心', address: '成都市锦江区红星路三段100号'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: showrooms.length,
      itemBuilder: (_, i) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                showrooms[i].city,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
          title: Text(showrooms[i].name,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(showrooms[i].address,
              style: const TextStyle(fontSize: 12, color: AppColors.grey500)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: Open showroom detail / map
          },
        ),
      ),
    );
  }
}

class _ShowroomItem {
  final String city;
  final String name;
  final String address;
  const _ShowroomItem(
      {required this.city, required this.name, required this.address});
}

class _GalleryTab extends StatelessWidget {
  const _GalleryTab();

  @override
  Widget build(BuildContext context) {
    final images = List.generate(
      9,
      (i) => 'https://picsum.photos/seed/gallery_$i/400/400',
    );

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: images.length,
      itemBuilder: (_, i) => GestureDetector(
        onTap: () {
          // TODO: Open full-screen gallery
        },
        child: Image.network(
          images[i],
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.grey200,
            child: const Icon(Icons.image),
          ),
        ),
      ),
    );
  }
}
