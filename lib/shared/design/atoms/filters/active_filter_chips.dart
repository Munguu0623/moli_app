// lib/filters/active_filter_chips.dart
import 'package:flutter/material.dart';
import 'university_filter.dart';

class ActiveFilterChips extends StatelessWidget {
  final UniversityFilter f;
  final VoidCallback onClear;
  const ActiveFilterChips({super.key, required this.f, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];
    if (f.location != null)
      chips.add(
        Chip(label: Text(f.location == UniLocation.ub ? 'УБ' : 'Хөдөө')),
      );
    if (f.type != null)
      chips.add(
        Chip(label: Text(f.type == UniType.public ? 'Төрийн' : 'Хувийн')),
      );
    if (f.tuition != const RangeValues(1, 10))
      chips.add(
        Chip(
          label: Text(
            'Төлбөр: ${f.tuition.start.round()}–${f.tuition.end.round()}cая₮',
          ),
        ),
      );
    if (f.entryScore != const RangeValues(400, 800))
      chips.add(
        Chip(
          label: Text(
            'Оноо: ${f.entryScore.start.round()}–${f.entryScore.end.round()}',
          ),
        ),
      );
    chips.addAll(f.categories.map((e) => Chip(label: Text(e))));
    if (chips.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...chips,
        ActionChip(
          label: const Text('Цэвэрлэх'),
          onPressed: onClear,
          avatar: const Icon(Icons.clear, size: 16),
        ),
      ],
    );
  }
}
