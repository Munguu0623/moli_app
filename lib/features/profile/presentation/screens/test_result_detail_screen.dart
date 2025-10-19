// lib/features/profile/presentation/screens/test_result_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../shared/design/design_system.dart';
import '../../../../core/widgets/molecules/custom_app_bar.dart';

/// Тестийн дүнгийн дэлгэрэнгүй хуудас
class TestResultDetailScreen extends ConsumerWidget {
  const TestResultDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock test result - RIASEC SEC
    const riasecCode = 'SEC';
    final traits = ['🧠 Хүмүүстэй ажиллах', '💼 Манлайлах', '📊 Журамтай'];

    final topOccupations = [
      {
        'icon': '👨‍💼',
        'title': 'Менежер',
        'fit': 92,
        'description': 'Багийн ажлыг удирдах, төлөвлөлт хийх',
      },
      {
        'icon': '👩‍🏫',
        'title': 'Багш',
        'fit': 88,
        'description': 'Сурагчдад мэдлэг дамжуулах, хөгжүүлэх',
      },
      {
        'icon': '👨‍⚕️',
        'title': 'Эмч',
        'fit': 85,
        'description': 'Хүмүүсийн эрүүл мэндийг хамгаалах',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Тестийн дүн',
        showBackButton: true,
        showNotification: false,
        showProfile: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RIASEC Code Card
            _buildRiasecCard(riasecCode),
            const Gap(20),

            // Traits
            _buildTraitsSection(traits),
            const Gap(24),

            // Top Occupations
            _buildSectionTitle('Танд тохирох мэргэжлүүд'),
            const Gap(12),
            ...topOccupations.map(
              (occ) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildOccupationCard(
                  context,
                  occ['icon'] as String,
                  occ['title'] as String,
                  occ['fit'] as int,
                  occ['description'] as String,
                ),
              ),
            ),

            const Gap(24),

            // CTAs
            _buildActionButtons(context),
            const Gap(16),
          ],
        ),
      ),
    );
  }

  Widget _buildRiasecCard(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppGradients.brand,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Таны RIASEC код',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(8),
          Text(
            code,
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 8,
            ),
          ),
          const Gap(8),
          const Text(
            'Social • Enterprising • Conventional',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTraitsSection(List<String> traits) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Таны гол шинж чанарууд'),
        const Gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: traits.map((trait) => _buildTraitChip(trait)).toList(),
        ),
      ],
    );
  }

  Widget _buildTraitChip(String trait) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.chipBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        trait,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildOccupationCard(
    BuildContext context,
    String icon,
    String title,
    int fit,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getFitColor(fit).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$fit% тохирно',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _getFitColor(fit),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getFitColor(int fit) {
    if (fit >= 90) return AppColors.success;
    if (fit >= 80) return AppColors.info;
    if (fit >= 70) return AppColors.warning;
    return AppColors.textSecondary;
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Дахин тест өгөх
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Navigate to test screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Дахин тест өгөх',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const Gap(12),

        // Мэргэжлүүд үзэх
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Navigate to occupations screen
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Бүх мэргэжлүүд үзэх',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
