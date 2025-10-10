// lib/filters/university_filter_sheet.dart
import 'package:flutter/material.dart';
import '../../design_system.dart';
import 'university_filter.dart';

class UniversityFilterSheet extends StatefulWidget {
  final UniversityFilter initial;
  final ValueChanged<UniversityFilter> onApply;
  const UniversityFilterSheet({
    super.key,
    required this.initial,
    required this.onApply,
  });

  @override
  State<UniversityFilterSheet> createState() => _UniversityFilterSheetState();
}

class _UniversityFilterSheetState extends State<UniversityFilterSheet> {
  late UniversityFilter f;
  final allCats = const ['IT', 'Санхүү', 'Эрүүл мэнд', 'Инженер', 'Дизайн'];

  @override
  void initState() {
    super.initState();
    f = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: AppGradients.brand,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Шүүлтүүр',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              _buildSectionLabel('Байршил'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: [
                  _buildChoiceChip(
                    'УБ',
                    f.location == UniLocation.ub,
                    () => setState(() {
                      f = f.copyWith(
                        location:
                            f.location == UniLocation.ub
                                ? null
                                : UniLocation.ub,
                      );
                    }),
                  ),
                  _buildChoiceChip(
                    'Хөдөө',
                    f.location == UniLocation.rural,
                    () => setState(() {
                      f = f.copyWith(
                        location:
                            f.location == UniLocation.rural
                                ? null
                                : UniLocation.rural,
                      );
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _buildSectionLabel('Төрөл'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: [
                  _buildChoiceChip(
                    'Төрийн',
                    f.type == UniType.public,
                    () => setState(() {
                      f = f.copyWith(
                        type: f.type == UniType.public ? null : UniType.public,
                      );
                    }),
                  ),
                  _buildChoiceChip(
                    'Хувийн',
                    f.type == UniType.private,
                    () => setState(() {
                      f = f.copyWith(
                        type:
                            f.type == UniType.private ? null : UniType.private,
                      );
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _buildSectionLabel(
                'Жилийн төлбөр (сая ₮): ${f.tuition.start.round()}–${f.tuition.end.round()}',
              ),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.border,
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withOpacity(0.2),
                  valueIndicatorColor: AppColors.primary,
                  rangeThumbShape: const RoundRangeSliderThumbShape(
                    enabledThumbRadius: 12,
                  ),
                  rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
                ),
                child: RangeSlider(
                  values: f.tuition,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  labels: RangeLabels(
                    '${f.tuition.start.round()}М',
                    '${f.tuition.end.round()}М',
                  ),
                  onChanged: (v) => setState(() => f = f.copyWith(tuition: v)),
                ),
              ),

              const SizedBox(height: 16),
              _buildSectionLabel(
                'Элсэлтийн оноо: ${f.entryScore.start.round()}–${f.entryScore.end.round()}',
              ),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.border,
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withOpacity(0.2),
                  valueIndicatorColor: AppColors.primary,
                  rangeThumbShape: const RoundRangeSliderThumbShape(
                    enabledThumbRadius: 12,
                  ),
                  rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
                ),
                child: RangeSlider(
                  values: f.entryScore,
                  min: 400,
                  max: 800,
                  divisions: 8,
                  labels: RangeLabels(
                    f.entryScore.start.round().toString(),
                    f.entryScore.end.round().toString(),
                  ),
                  onChanged:
                      (v) => setState(() => f = f.copyWith(entryScore: v)),
                ),
              ),

              const SizedBox(height: 16),
              _buildSectionLabel('Чиглэл'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final c in allCats)
                    _buildFilterChip(c, f.categories.contains(c), () {
                      setState(() {
                        final list = [...f.categories];
                        list.contains(c) ? list.remove(c) : list.add(c);
                        f = f.copyWith(categories: list);
                      });
                    }),
                ],
              ),

              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: _buildOutlinedButton(
                      'Арилгах',
                      () => setState(() => f = const UniversityFilter()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: _buildPrimaryButton('Хэрэглэх', () {
                      widget.onApply(f);
                      Navigator.pop(context);
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool selected, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: selected ? AppGradients.brand : null,
            color: selected ? null : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.chip),
            border: Border.all(
              color: selected ? Colors.transparent : AppColors.border,
              width: 2,
            ),
            boxShadow: selected ? AppShadows.button : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.chipPurple : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.chip),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 2 : 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected)
                const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.check_circle,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
              Text(
                label,
                style: TextStyle(
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(String label, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: Border.all(color: AppColors.border, width: 2),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String label, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.button),
        splashColor: Colors.white.withOpacity(0.2),
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppGradients.brand,
            borderRadius: BorderRadius.circular(AppRadius.button),
            boxShadow: AppShadows.button,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
