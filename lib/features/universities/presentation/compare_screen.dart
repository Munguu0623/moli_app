// lib/features/universities/presentation/compare_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../../../core/widgets/atoms/dialogs.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/organisms/university_compare_table.dart';
import '../../../shared/design/design_system.dart';
import '../application/compare_provider.dart';

/// Их сургуулиудыг харьцуулах хуудас
class CompareScreen extends ConsumerWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compareCart = ref.watch(compareCartProvider);

    if (compareCart.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Харьцуулах')),
        body: const EmptyState(
          title: 'Харьцуулах сургууль байхгүй',
          subtitle: 'Сургуулиудын жагсаалтаас "Харьцуулах" товч дарж нэмнэ үү',
          icon: Icons.compare_arrows,
        ),
      );
    }

    // Convert to CompareUniversity for table
    final compareUniversities =
        compareCart.map((u) {
          return CompareUniversity(
            name: u.name,
            logoUrl: u.logoUrl,
            location: u.location,
            tuition: u.tuitionRange,
            entryScore: u.avgEntryScore,
            programs: u.totalPrograms,
            dorm: u.hasDormitory,
            rating: u.rating,
            verified: u.verified,
          );
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сургуулиуд харьцуулах'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              showAppSnack(context, 'Харьцуулалт хуваалцагдлаа!');
            },
            tooltip: 'Хуваалцах',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showConfirmDialog(
                context,
                message: 'Бүх харьцуулалтыг арилгах уу?',
              ).then((confirmed) {
                if (confirmed) {
                  ref.read(compareCartProvider.notifier).clear();
                  Navigator.pop(context);
                }
              });
            },
            tooltip: 'Арилгах',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Title
          const Text(
            'Сонгосон сургуулиудыг харьцуулах',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${compareCart.length} сургууль',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),

          // Compare table
          UniversityCompareTable(items: compareUniversities),

          const SizedBox(height: 24),

          // Tips card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Зөвлөмж',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Элсэлтийн босго, төлбөр, хөтөлбөрийн тоо зэрэг үзүүлэлтүүдийг харьцуулж таны хэрэгцээнд тохирсон сургуулиа сонгоорой.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTipRow(
                  '• Элсэлтийн босго:',
                  'Таны ЭЕШ оноонд тохирч байгаа эсэхийг шалгаарай',
                ),
                const SizedBox(height: 8),
                _buildTipRow(
                  '• Төлбөр:',
                  'Жилийн болон нийт төлбөрийг харьцуулж, санхүүгийн төлөвлөгөө хий',
                ),
                const SizedBox(height: 8),
                _buildTipRow(
                  '• Байр:',
                  'Дотуур байртай эсэхийг анхаарч, зардлаа тооцоолоорой',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Actions
          Row(
            children:
                compareCart.map((university) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AppButton.primary(
                        university.name.length > 10
                            ? '${university.name.substring(0, 10)}...'
                            : university.name,
                        onPressed: () {
                          showAppSnack(
                            context,
                            '${university.name} сонгогдлоо!',
                          );
                        },
                        expanded: true,
                      ),
                    ),
                  );
                }).toList(),
          ),

          const SizedBox(height: 16),

          // Clear button
          SizedBox(
            width: double.infinity,
            child: AppButton.secondary(
              'Бүгдийг арилгах',
              onPressed: () {
                ref.read(compareCartProvider.notifier).clear();
                Navigator.pop(context);
              },
              expanded: true,
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTipRow(String label, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
