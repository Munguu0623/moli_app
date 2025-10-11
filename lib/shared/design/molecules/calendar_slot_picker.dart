import 'package:flutter/material.dart';
import '../design_system.dart';

class CalendarSlotPicker extends StatefulWidget {
  final DateTime initial;
  final List<TimeOfDay> slots;
  final void Function(DateTime date, TimeOfDay slot) onSelect;
  final String submitButtonText;

  const CalendarSlotPicker({
    super.key,
    required this.initial,
    required this.slots,
    required this.onSelect,
    this.submitButtonText = 'Хүсэлт илгээх',
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
        // Date picker
        SizedBox(
          height: 82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            itemCount: 14,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) {
              final d = widget.initial.add(Duration(days: i));
              final item = DateTime(d.year, d.month, d.day);
              final isSel = _isSameDay(item, _selectedDate);
              final isToday = _isSameDay(item, DateTime.now());

              return InkWell(
                onTap:
                    () => setState(() {
                      _selectedDate = item;
                      _selectedSlot = null;
                    }),
                borderRadius: BorderRadius.circular(AppRadius.chip),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 68,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSel ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(
                      color: isSel ? AppColors.primary : AppColors.border,
                      width: isSel ? 2 : 1,
                    ),
                    boxShadow: isSel ? AppShadows.button : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _wd(item),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color:
                              isSel
                                  ? Colors.white
                                  : isToday
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${item.month}/${item.day}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isSel ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        // Time slots
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [for (final s in widget.slots) _buildTimeSlot(s)],
        ),
        const SizedBox(height: 20),
        // Submit button
        SizedBox(
          width: double.infinity,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:
                  _selectedSlot == null
                      ? null
                      : () => widget.onSelect(_selectedDate, _selectedSlot!),
              borderRadius: BorderRadius.circular(AppRadius.button),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: _selectedSlot == null ? null : AppGradients.brand,
                  color: _selectedSlot == null ? AppColors.border : null,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  boxShadow: _selectedSlot == null ? null : AppShadows.button,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    widget.submitButtonText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:
                          _selectedSlot == null
                              ? AppColors.textTertiary
                              : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlot(TimeOfDay slot) {
    final isSelected = _selectedSlot == slot;

    return InkWell(
      onTap: () => setState(() => _selectedSlot = slot),
      borderRadius: BorderRadius.circular(AppRadius.chip),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withOpacity(0.12)
                  : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          _fmt(slot),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ),
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
