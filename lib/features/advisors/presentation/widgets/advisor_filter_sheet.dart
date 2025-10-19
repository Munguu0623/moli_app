// lib/features/advisors/presentation/widgets/advisor_filter_sheet.dart

import 'package:flutter/material.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/advisor.dart';
import '../../domain/models/advisor_filter.dart';

/// Зөвлөхүүдийн шүүлтүүр sheet
class AdvisorFilterSheet extends StatefulWidget {
  final AdvisorFilter initial;
  final ValueChanged<AdvisorFilter> onApply;

  const AdvisorFilterSheet({
    super.key,
    required this.initial,
    required this.onApply,
  });

  @override
  State<AdvisorFilterSheet> createState() => _AdvisorFilterSheetState();
}

class _AdvisorFilterSheetState extends State<AdvisorFilterSheet> {
  late AdvisorFilter f;

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

              // Мэргэжлийн чиглэл
              _buildSectionLabel('Мэргэжлийн чиглэл'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children:
                    AdvisorExpertise.values.map((exp) {
                      final isSelected = f.expertise.contains(exp);
                      return _buildChoiceChip(exp.label, isSelected, () {
                        setState(() {
                          if (isSelected) {
                            f = f.copyWith(
                              expertise:
                                  f.expertise.where((e) => e != exp).toList(),
                            );
                          } else {
                            f = f.copyWith(expertise: [...f.expertise, exp]);
                          }
                        });
                      });
                    }).toList(),
              ),

              const SizedBox(height: 24),

              // Үнийн хүрээ
              _buildSectionLabel('Үнийн хүрээ (₮)'),
              const SizedBox(height: 8),
              RangeSlider(
                values: f.priceRange,
                min: 0,
                max: 20000,
                divisions: 40,
                labels: RangeLabels(
                  f.priceRange.start == 0
                      ? 'Үнэгүй'
                      : '${f.priceRange.start.toInt()}₮',
                  '${f.priceRange.end.toInt()}₮',
                ),
                activeColor: AppColors.primary,
                inactiveColor: AppColors.border,
                onChanged: (values) {
                  setState(() {
                    f = f.copyWith(priceRange: values);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      f.priceRange.start == 0
                          ? 'Үнэгүй'
                          : '${f.priceRange.start.toInt()}₮',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${f.priceRange.end.toInt()}₮',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Хэл
              _buildSectionLabel('Хэл'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children:
                    ['Монгол', 'English', 'Орос'].map((lang) {
                      final isSelected = f.languages.contains(lang);
                      return _buildChoiceChip(lang, isSelected, () {
                        setState(() {
                          if (isSelected) {
                            f = f.copyWith(
                              languages:
                                  f.languages.where((l) => l != lang).toList(),
                            );
                          } else {
                            f = f.copyWith(languages: [...f.languages, lang]);
                          }
                        });
                      });
                    }).toList(),
              ),

              const SizedBox(height: 24),

              // Өнөөдөр боломжтой
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.chipBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(
                    color:
                        f.availableToday ? AppColors.primary : AppColors.border,
                    width: f.availableToday ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Өнөөдөр боломжтой',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Switch(
                      value: f.availableToday,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          f = f.copyWith(availableToday: value);
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          f = const AdvisorFilter();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                          color: AppColors.border,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.button),
                        ),
                      ),
                      child: const Text(
                        'Арилгах',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.onApply(f);
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(AppRadius.button),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: AppGradients.brand,
                            borderRadius: BorderRadius.circular(
                              AppRadius.button,
                            ),
                            boxShadow: AppShadows.button,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.center,
                            child: Text(
                              'Хайх (${f.activeFilterCount > 0 ? f.activeFilterCount : "бүгд"})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool selected, VoidCallback onTap) {
    return InkWell(
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
            width: selected ? 2 : 1,
          ),
          boxShadow: selected ? AppShadows.card : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
