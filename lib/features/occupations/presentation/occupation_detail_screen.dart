// lib/features/occupations/presentation/occupation_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/molecules/section_header.dart';
import '../../../core/widgets/molecules/sticky_cta.dart';
import '../../../shared/design/design_system.dart';
import '../application/occupations_provider.dart';
import '../domain/entities/occupation.dart';
import '../domain/entities/skill.dart';
import 'widgets/occupation_info_row.dart';
import 'widgets/skill_chip.dart';

/// Мэргэжлийн дэлгэрэнгүй хуудас
class OccupationDetailScreen extends ConsumerStatefulWidget {
  final String occupationId;

  const OccupationDetailScreen({super.key, required this.occupationId});

  @override
  ConsumerState<OccupationDetailScreen> createState() =>
      _OccupationDetailScreenState();
}

class _OccupationDetailScreenState extends ConsumerState<OccupationDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final occupation = ref.watch(occupationProvider(widget.occupationId));

    if (occupation == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Мэргэжил')),
        body: const EmptyState(
          title: 'Мэргэжил олдсонгүй',
          subtitle: 'Энэ мэргэжил олдохгүй байна',
          icon: Icons.error_outline,
        ),
      );
    }

    final outlookColor = _getOutlookColor(occupation.demandOutlook);

    return Scaffold(
      appBar: AppBar(
        title: Text(occupation.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Хадгаллаа')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Хуваалцах функц удахгүй нэмэгдэнэ'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppGradients.brand,
              boxShadow: AppShadows.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Code badge
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
                    occupation.code,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Summary
                Text(
                  occupation.summary,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 16),

                // Quick info
                Row(
                  children: [
                    _buildQuickInfo(
                      icon: Icons.monetization_on_outlined,
                      label: occupation.salaryRange.formattedMedian,
                    ),
                    const SizedBox(width: 16),
                    _buildQuickInfo(
                      icon: _getOutlookIcon(occupation.demandOutlook),
                      label: occupation.outlookLabel,
                    ),
                  ],
                ),

                if (occupation.rating != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${occupation.rating!.toStringAsFixed(1)} (${occupation.reviewCount} үнэлгээ)',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Tabs
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: 'Тойм'),
                Tab(text: 'Ур чадвар'),
                Tab(text: 'Цалин & Эрэлт'),
                Tab(text: 'Карьер'),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(occupation),
                _buildSkillsTab(occupation),
                _buildSalaryTab(occupation, outlookColor),
                _buildCareerTab(occupation),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: StickyCTA(
        child: Row(
          children: [
            Expanded(
              child: AppButton.secondary(
                'Зөвлөгөө авах',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Зөвлөх модуль руу шилжинэ')),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.primary(
                'Хөтөлбөр харах',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Холбогдох хөтөлбөрүүд руу шилжинэ'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Тойм tab
  Widget _buildOverviewTab(Occupation occupation) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader('Гол үүрэг'),
        const SizedBox(height: 12),
        ...occupation.tasks.map(
          (task) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    task,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        const SectionHeader('Ажлын орчин'),
        const SizedBox(height: 12),
        OccupationInfoRow(
          icon: Icons.location_city_outlined,
          label: 'Орчин',
          value: occupation.workContext.environment,
        ),
        const SizedBox(height: 10),
        OccupationInfoRow(
          icon: Icons.schedule_outlined,
          label: 'Цагийн хуваарь',
          value: occupation.workContext.schedule,
        ),
        const SizedBox(height: 10),
        OccupationInfoRow(
          icon: Icons.fitness_center_outlined,
          label: 'Бие махбодийн ачаалал',
          value: occupation.workContext.physicalDemand,
        ),
        if (occupation.workContext.remoteOption) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.cardCompact),
              border: Border.all(color: AppColors.success.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.home_work_outlined,
                  color: AppColors.success,
                  size: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Алсаас ажиллах боломжтой',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 24),
      ],
    );
  }

  // Ур чадвар tab
  Widget _buildSkillsTab(Occupation occupation) {
    final hardSkills =
        occupation.skillsRequired
            .where((s) => s.type == SkillType.hard)
            .toList();
    final softSkills =
        occupation.skillsRequired
            .where((s) => s.type == SkillType.soft)
            .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (hardSkills.isNotEmpty) ...[
          const SectionHeader('Техникийн ур чадвар'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                hardSkills.map((skill) => SkillChip(skill: skill)).toList(),
          ),
          const SizedBox(height: 24),
        ],

        if (softSkills.isNotEmpty) ...[
          const SectionHeader('Зөөлөн ур чадвар'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                softSkills.map((skill) => SkillChip(skill: skill)).toList(),
          ),
          const SizedBox(height: 24),
        ],

        // Info box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.chipBlue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Ур чадварын талаар',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Энэ мэргэжилд ажиллахын тулд дээрх ур чадваруудыг эзэмшсэн байх шаардлагатай. '
                'Холбогдох хөтөлбөрүүдэд суралцаж эдгээр ур чадваруудыг хөгжүүлэх боломжтой.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Цалин & Эрэлт tab
  Widget _buildSalaryTab(Occupation occupation, Color outlookColor) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader('Цалингийн хэмжээ'),
        const SizedBox(height: 12),

        // Median salary card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppGradients.success,
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: AppShadows.card,
          ),
          child: Column(
            children: [
              const Text(
                'Дундаж цалин',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                occupation.salaryRange.formattedMedian,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Range
        Row(
          children: [
            Expanded(
              child: OccupationInfoRow(
                icon: Icons.trending_down,
                label: 'Доод',
                value: occupation.salaryRange.min.toStringAsFixed(0),
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OccupationInfoRow(
                icon: Icons.trending_up,
                label: 'Дээд',
                value: occupation.salaryRange.max.toStringAsFixed(0),
                color: AppColors.primary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        const SectionHeader('Ирээдүйн эрэлт хандлага'),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: outlookColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: outlookColor.withOpacity(0.3), width: 2),
          ),
          child: Column(
            children: [
              Icon(
                _getOutlookIcon(occupation.demandOutlook),
                size: 48,
                color: outlookColor,
              ),
              const SizedBox(height: 12),
              Text(
                occupation.outlookLabel,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: outlookColor,
                ),
              ),
              if (occupation.outlookDescription != null) ...[
                const SizedBox(height: 12),
                Text(
                  occupation.outlookDescription!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Related programs count
        OccupationInfoRow(
          icon: Icons.school_outlined,
          label: 'Холбогдох хөтөлбөр',
          value: '${occupation.relatedProgramsCount} хөтөлбөр',
          color: AppColors.primary,
        ),
      ],
    );
  }

  // Карьер tab
  Widget _buildCareerTab(Occupation occupation) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader('Карьерын замнал'),
        const SizedBox(height: 12),

        if (occupation.careerPaths.isEmpty)
          const EmptyState(
            title: 'Карьерын мэдээлэл одоогоор байхгүй',
            subtitle: 'Удахгүй нэмэгдэнэ',
            icon: Icons.timeline_outlined,
          )
        else
          ...occupation.careerPaths.map((path) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.border),
                boxShadow: AppShadows.card,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_upward,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          path.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    path.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_outlined,
                        size: 16,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${path.yearsRequired} жил',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }

  Widget _buildQuickInfo({required IconData icon, required String label}) {
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

  Color _getOutlookColor(DemandOutlook outlook) {
    switch (outlook) {
      case DemandOutlook.growing:
        return AppColors.success;
      case DemandOutlook.stable:
        return AppColors.info;
      case DemandOutlook.declining:
        return AppColors.error;
    }
  }

  IconData _getOutlookIcon(DemandOutlook outlook) {
    switch (outlook) {
      case DemandOutlook.growing:
        return Icons.trending_up;
      case DemandOutlook.stable:
        return Icons.remove;
      case DemandOutlook.declining:
        return Icons.trending_down;
    }
  }
}
