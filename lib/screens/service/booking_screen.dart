import 'package:flutter/material.dart';
import 'package:starmotor/models/service_model.dart';

class BookingScreen extends StatefulWidget {
  final ServiceModel service;

  const BookingScreen({super.key, required this.service});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _step = 0;
  String? _selectedCenter;
  DateTime? _selectedDate;
  final _notesController = TextEditingController();

  static const _centers = [
    '星驰北京朝阳服务中心',
    '星驰上海浦东服务中心',
    '星驰广州天河服务中心',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('预约 ${widget.service.name}')),
      body: Stepper(
        currentStep: _step,
        onStepContinue: _step < 2
            ? () => setState(() => _step++)
            : null,
        onStepCancel: _step > 0
            ? () => setState(() => _step--)
            : null,
        steps: [
          Step(
            title: const Text('选择服务中心'),
            isActive: _step >= 0,
            state: _step > 0 ? StepState.complete : StepState.indexed,
            content: Column(
              children: _centers
                  .map((c) => RadioListTile<String>(
                        value: c,
                        groupValue: _selectedCenter,
                        onChanged: (v) =>
                            setState(() => _selectedCenter = v),
                        title: Text(c),
                      ))
                  .toList(),
            ),
          ),
          Step(
            title: const Text('选择时间'),
            isActive: _step >= 1,
            state: _step > 1 ? StepState.complete : StepState.indexed,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _selectedDate == null
                      ? '未选择日期'
                      : '已选：${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now()
                          .add(const Duration(days: 1)),
                      firstDate: DateTime.now()
                          .add(const Duration(days: 1)),
                      lastDate: DateTime.now()
                          .add(const Duration(days: 60)),
                    );
                    if (date != null) {
                      setState(() => _selectedDate = date);
                    }
                  },
                  child: const Text('选择日期'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: '备注（可选）',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          Step(
            title: const Text('确认预约'),
            isActive: _step >= 2,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _InfoRow(
                    label: '服务项目', value: widget.service.name),
                _InfoRow(
                    label: '服务中心',
                    value: _selectedCenter ?? '-'),
                _InfoRow(
                  label: '预约时间',
                  value: _selectedDate == null
                      ? '-'
                      : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                ),
                if (_notesController.text.isNotEmpty)
                  _InfoRow(
                      label: '备注',
                      value: _notesController.text),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('预约成功！服务顾问将确认您的预约')),
                    );
                  },
                  child: const Text('确认预约'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: const TextStyle(color: Colors.grey)),
          ),
          Text(value),
        ],
      ),
    );
  }
}
