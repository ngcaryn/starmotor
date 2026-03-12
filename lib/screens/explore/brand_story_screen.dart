import 'package:flutter/material.dart';

class BrandStoryScreen extends StatelessWidget {
  const BrandStoryScreen({super.key});

  static const _milestones = [
    {'year': '2015', 'text': '星驰汽车在北京成立，立志打造高端智能电动汽车'},
    {'year': '2019', 'text': '首款增程式电动车星驰ONE正式交付'},
    {'year': '2021', 'text': '星驰L9、L8相继发布，开创六座旗舰SUV新品类'},
    {'year': '2022', 'text': '年交付量突破13万辆，跻身新能源高端市场第一阵营'},
    {'year': '2023', 'text': '发布800V高压平台，星驰L6上市，销量持续攀升'},
    {'year': '2024', 'text': '全球首款智能座舱与高阶智驾全融合车型正式亮相'},
  ];

  static const _events = [
    {
      'title': '星驰春季品鉴会',
      'date': '2024-04-15',
      'location': '上海国家会展中心',
    },
    {
      'title': '全国试驾季',
      'date': '2024-05-01',
      'location': '全国50城同步',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('探索'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '品牌故事'),
              Tab(text: '活动'),
              Tab(text: '展厅'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _BrandStoryTab(milestones: _milestones),
            _EventsTab(events: _events),
            const _ShowroomTab(),
          ],
        ),
      ),
    );
  }
}

class _BrandStoryTab extends StatelessWidget {
  final List<Map<String, String>> milestones;
  const _BrandStoryTab({required this.milestones});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            'https://picsum.photos/seed/brand/600/250',
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        const Text('关于星驰',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          '星驰汽车是一家以用户价值为核心的智能电动汽车企业，致力于为家庭用户提供最优质的出行体验。'
          '我们相信，出行不仅仅是从A到B，更是家庭生活的延伸。',
          style: TextStyle(height: 1.6),
        ),
        const SizedBox(height: 24),
        const Text('发展历程',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...milestones.map((m) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(m['year']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  ),
                  Expanded(child: Text(m['text']!)),
                ],
              ),
            )),
      ],
    );
  }
}

class _EventsTab extends StatelessWidget {
  final List<Map<String, String>> events;
  const _EventsTab({required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.event, color: Colors.blue),
            title: Text(event['title']!),
            subtitle: Text('${event['date']} · ${event['location']}'),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              child: const Text('报名'),
            ),
          ),
        );
      },
    );
  }
}

class _ShowroomTab extends StatelessWidget {
  const _ShowroomTab();

  static const _centers = [
    {'name': '星驰北京朝阳体验中心', 'address': '朝阳区望京SOHO T1 1F', 'phone': '010-8888-0001'},
    {'name': '星驰上海浦东旗舰店', 'address': '浦东新区陆家嘴环路800号', 'phone': '021-6888-0001'},
    {'name': '星驰广州天河展厅', 'address': '天河区天河路385号', 'phone': '020-3888-0001'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _centers.length,
      itemBuilder: (context, index) {
        final center = _centers[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(center['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(center['address']!,
                      style: Theme.of(context).textTheme.bodyMedium),
                ]),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.phone, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(center['phone']!,
                      style: Theme.of(context).textTheme.bodyMedium),
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
