import 'package:flutter/material.dart';
import '../design_system.dart';

class CalendarSlotPicker extends StatefulWidget {
  final DateTime initial; // default: today
  final List<TimeOfDay> slots; // ж: [16:00, 17:00, 18:00]
  final void Function(DateTime date, TimeOfDay slot) onSelect;

  const CalendarSlotPicker({
    super.key,
    required this.initial,
    required this.slots,
    required this.onSelect,
  });

  @override
  State<CalendarSlotPicker> createState() => _CalendarSlotPickerState();
}

class _CalendarSlotPickerState extends State<CalendarSlotPicker> {
  late DateTime _selectedDate;
  TimeOfDay? _selectedSlot;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(
      widget.initial.year,
      widget.initial.month,
      widget.initial.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date picker (мобайлд тохиромжтой хөнгөн хувилбар)
        SizedBox(
          height: 92,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 14,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final d = _selectedDate.add(Duration(days: i - 0));
              final item = DateTime(d.year, d.month, d.day);
              final isSel = _isSameDay(item, _selectedDate);
              return InkWell(
                onTap:
                    () => setState(() {
                      _selectedDate = item;
                      _selectedSlot = null;
                    }),
                borderRadius: BorderRadius.circular(12),
                child: Ink(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isSel
                            ? AppColors.primary.withOpacity(.12)
                            : AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isSel ? AppColors.primary : const Color(0xFFE0E0E0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _wd(item),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color:
                              isSel ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${item.month}/${item.day}',
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Slot chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in widget.slots)
              ChoiceChip(
                label: Text(_fmt(s)),
                selected: _selectedSlot == s,
                onSelected: (_) => setState(() => _selectedSlot = s),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                _selectedSlot == null
                    ? null
                    : () => widget.onSelect(_selectedDate, _selectedSlot!),
            child: const Text('Хүсэлт илгээх'),
          ),
        ),
      ],
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _wd(DateTime d) {
    const days = ['Ня', 'Да', 'Мя', 'Лх', 'Пү', 'Ба', 'Бя'];
    return days[d.weekday % 7];
  }

  String _fmt(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, "0")}:${t.minute.toString().padLeft(2, "0")}';
}
