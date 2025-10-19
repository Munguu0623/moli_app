// lib/features/universities/presentation/program_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/molecules/section_header.dart';
import '../../../shared/design/design_system.dart';
import '../application/universities_provider.dart';

/// Хөтөлбөрийн дэлгэрэнгүй хуудас
class ProgramDetailScreen extends ConsumerWidget {
  final String programId;

  const ProgramDetailScreen({super.key, required this.programId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final program = ref.watch(programDetailProvider(programId));

    if (program == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Хөтөлбөр')),
        body: const EmptyState(
          title: 'Хөтөлбөр олдсонгүй',
          subtitle: 'Энэ хөтөлбөр олдохгүй байна',
          icon: Icons.error_outline,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(program.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppGradients.brand,
              borderRadius: BorderRadius.circular(AppRadius.card),
              boxShadow: AppShadows.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        program.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        program.category,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildWhiteInfoChip(
                      icon: Icons.schedule,
                      label: program.duration,
                    ),
                    const SizedBox(width: 12),
                    _buildWhiteInfoChip(
                      icon: Icons.language,
                      label: program.language,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildWhiteInfoChip(
                      icon: Icons.trending_up,
                      label: 'Оноо: ${program.entryScore}',
                    ),
                    const SizedBox(width: 12),
                    _buildWhiteInfoChip(
                      icon: Icons.monetization_on_outlined,
                      label: program.tuitionPerYear,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Description
          const SectionHeader('Танилцуулга'),
          const SizedBox(height: 12),
          Text(
            program.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          // Main subjects
          if (program.mainSubjects.isNotEmpty) ...[
            const SectionHeader('Гол хичээлүүд'),
            const SizedBox(height: 12),
            ...program.mainSubjects.map(
              (subject) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        subject,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Related careers
          if (program.relatedCareerIds.isNotEmpty) ...[
            const SectionHeader('Холбогдох мэргэжлүүд'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.chipBlue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.work_outline,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Энэ хөтөлбөр төгсөөд эдгээр мэргэжилд ажиллах боломжтой:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        program.relatedCareerIds
                            .map(
                              (careerId) => Chip(
                                label: Text(_formatCareerId(careerId)),
                                backgroundColor: AppColors.chipPurple,
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Actions
          // Row(
          //   children: [
          //     Expanded(
          //       child: AppButton.secondary(
          //         'Зөвлөгөө авах',
          //         onPressed: () {
          //           // TODO: Navigate to advisors
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(content: Text('Зөвлөхүүд руу шилжинэ...')),
          //           );
          //         },
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Expanded(
          //       child: AppButton.primary(
          //         'Харьцуулах',
          //         onPressed: () {
          //           // TODO: Add to compare
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(content: Text('Харьцуулалтад нэмэгдлээ')),
          //           );
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildWhiteInfoChip({required IconData icon, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _formatCareerId(String id) {
    // Mock format - convert snake_case to readable
    return id
        .split('_')
        .map((word) {
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}
