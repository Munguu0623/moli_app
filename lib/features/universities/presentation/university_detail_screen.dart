// lib/features/universities/presentation/university_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../../../core/widgets/atoms/badges.dart';
import '../../../core/widgets/atoms/cached_image.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/molecules/app_tabs.dart';
import '../../../shared/design/design_system.dart';
import '../application/bookmark_provider.dart';
import '../application/compare_provider.dart';
import '../application/universities_provider.dart';
import 'program_detail_screen.dart';
import 'widgets/admission_countdown.dart';
import 'widgets/program_card.dart';
import 'widgets/tuition_calculator_widget.dart';

/// Их сургуулийн дэлгэрэнгүй хуудас
class UniversityDetailScreen extends ConsumerStatefulWidget {
  final String universityId;

  const UniversityDetailScreen({super.key, required this.universityId});

  @override
  ConsumerState<UniversityDetailScreen> createState() =>
      _UniversityDetailScreenState();
}

class _UniversityDetailScreenState
    extends ConsumerState<UniversityDetailScreen> {
  String? _selectedProgramCategory;

  @override
  Widget build(BuildContext context) {
    final universityAsync = ref.watch(
      universityDetailProvider(widget.universityId),
    );

    return universityAsync.when(
      data: (university) {
        if (university == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const EmptyState(
              title: 'Сургууль олдсонгүй',
              subtitle: 'Энэ сургууль устсан эсвэл олдохгүй байна',
              icon: Icons.error_outline,
            ),
          );
        }

        final isBookmarked = ref
            .watch(bookmarkedUniversitiesProvider)
            .contains(university.id);
        final isInCompare = ref
            .watch(compareCartProvider)
            .any((u) => u.id == university.id);

        return Scaffold(
          appBar: AppBar(
            title: Text(university.name, style: const TextStyle(fontSize: 18)),
            actions: [
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color:
                      isBookmarked ? AppColors.accent : AppColors.textPrimary,
                ),
                onPressed: () => _handleBookmark(context, university.id),
              ),
            ],
          ),
          body: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    CachedRoundImage(
                      url: university.logoUrl,
                      size: 80,
                      placeholder: const Icon(
                        Icons.school,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  university.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              if (university.verified)
                                const VerifiedBadge(size: 18),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                university.location,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.star_rounded,
                                size: 18,
                                color: AppColors.accent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                university.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tabs
              Expanded(
                child: AppTabs(
                  tabs: const [
                    'Тойм',
                    'Хөтөлбөр',
                    'Санхүү',
                    'Кампус',
                    'Элсэлт',
                  ],
                  pages: [
                    _buildOverviewTab(context, university),
                    _buildProgramsTab(context, university.id),
                    _buildTuitionTab(context, university.id),
                    _buildCampusTab(context, university.id),
                    _buildAdmissionTab(context, university.id),
                  ],
                ),
              ),

              // Sticky CTA
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton.secondary(
                        isInCompare
                            ? 'Харьцуулалтад нэмэгдсэн ✓'
                            : 'Харьцуулах',
                        onPressed: () => _handleCompare(context, university),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton.primary(
                        'Албан сайт',
                        onPressed: () => _launchURL(university.website),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading:
          () => Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          ),
      error:
          (error, stack) => Scaffold(
            appBar: AppBar(),
            body: EmptyState(
              title: 'Алдаа гарлаа',
              subtitle: error.toString(),
              icon: Icons.error_outline,
            ),
          ),
    );
  }

  // Tab 1: Overview
  Widget _buildOverviewTab(BuildContext context, university) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Ерөнхий мэдээлэл'),
        const SizedBox(height: 12),
        _buildInfoCard([
          _buildInfoRow('Төрөл:', university.typeLabel),
          _buildInfoRow('Үүсгэн байгуулсан:', '${university.foundedYear} он'),
          _buildInfoRow('Хөтөлбөрийн тоо:', '${university.totalPrograms}'),
          _buildInfoRow('Төлбөрийн муж:', university.tuitionRange),
          _buildInfoRow('Элсэлтийн дундаж:', '${university.avgEntryScore}'),
          _buildInfoRow(
            'Дотуур байр:',
            university.hasDormitory ? 'Байна ✓' : 'Байхгүй',
          ),
        ]),
        const SizedBox(height: 16),
        _buildSectionTitle('Тайлбар'),
        const SizedBox(height: 8),
        Text(
          university.description,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),
        if (university.campusImageUrl != null) ...[
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.card),
            child: Image.network(
              university.campusImageUrl!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
        const SizedBox(height: 80),
      ],
    );
  }

  // Tab 2: Programs
  Widget _buildProgramsTab(BuildContext context, String universityId) {
    final programsAsync = ref.watch(universityProgramsProvider(universityId));

    return programsAsync.when(
      data: (programs) {
        if (programs.isEmpty) {
          return const EmptyState(
            title: 'Хөтөлбөр олдсонгүй',
            subtitle: 'Энэ сургуульд хөтөлбөр байхгүй байна',
            icon: Icons.school_outlined,
          );
        }

        // Get unique categories
        final categories = programs.map((p) => p.category).toSet().toList();
        final filteredPrograms =
            _selectedProgramCategory == null
                ? programs
                : programs
                    .where((p) => p.category == _selectedProgramCategory)
                    .toList();

        return Column(
          children: [
            // Category filter
            if (categories.length > 1)
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    if (i == 0) {
                      return _buildCategoryChip('Бүгд', null);
                    }
                    final cat = categories[i - 1];
                    return _buildCategoryChip(cat, cat);
                  },
                ),
              ),

            // Programs list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: filteredPrograms.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final program = filteredPrograms[i];
                  return ProgramCard(
                    program: program,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (_) => ProgramDetailScreen(programId: program.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (e, s) => EmptyState(
            title: 'Алдаа',
            subtitle: e.toString(),
            icon: Icons.error,
          ),
    );
  }

  Widget _buildCategoryChip(String label, String? category) {
    final isSelected = _selectedProgramCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedProgramCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? AppGradients.brand : null,
          color: isSelected ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.border,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  // Tab 3: Tuition
  Widget _buildTuitionTab(BuildContext context, String universityId) {
    final tuitionInfo = ref.watch(universityTuitionProvider(universityId));

    if (tuitionInfo == null) {
      return const EmptyState(
        title: 'Мэдээлэл байхгүй',
        subtitle: 'Санхүүгийн мэдээлэл одоогоор байхгүй байна',
        icon: Icons.info_outline,
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Сургалтын төлбөр'),
        const SizedBox(height: 12),
        _buildInfoCard([
          _buildInfoRow('Жилд:', tuitionInfo.perYear),
          _buildInfoRow('Семистерт:', tuitionInfo.perSemester),
        ]),
        const SizedBox(height: 16),
        _buildSectionTitle('Тэтгэлэг'),
        const SizedBox(height: 8),
        Text(
          tuitionInfo.scholarshipInfo,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Зээл'),
        const SizedBox(height: 8),
        Text(
          tuitionInfo.loanAvailable
              ? '✓ ${tuitionInfo.loanConditions}'
              : '✗ Зээл авах боломжгүй',
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),
        if (tuitionInfo.additionalFees.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildSectionTitle('Нэмэлт төлбөрүүд'),
          const SizedBox(height: 12),
          _buildInfoCard(
            tuitionInfo.additionalFees.entries
                .map((e) => _buildInfoRow('${e.key}:', e.value))
                .toList(),
          ),
        ],
        const SizedBox(height: 24),
        _buildSectionTitle('Зардлын тооцоолуур'),
        const SizedBox(height: 12),
        TuitionCalculatorWidget(tuitionInfo: tuitionInfo),
        const SizedBox(height: 80),
      ],
    );
  }

  // Tab 4: Campus Life
  Widget _buildCampusTab(BuildContext context, String universityId) {
    final campusLife = ref.watch(universityCampusLifeProvider(universityId));
    final dormitory = ref.watch(universityDormitoryProvider(universityId));

    if (campusLife == null && dormitory == null) {
      return const EmptyState(
        title: 'Мэдээлэл байхгүй',
        subtitle: 'Кампусын мэдээлэл одоогоор байхгүй байна',
        icon: Icons.info_outline,
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (dormitory != null) ...[
          _buildSectionTitle('Дотуур байр'),
          const SizedBox(height: 12),
          _buildInfoCard([
            _buildInfoRow('Нэр:', dormitory.name),
            _buildInfoRow('Сарын үнэ:', dormitory.pricePerMonth),
            _buildInfoRow('Өрөөний төрөл:', dormitory.roomType),
            _buildInfoRow(
              'Чөлөөт байр:',
              dormitory.available ? 'Байна ✓' : 'Дүүрсэн',
            ),
          ]),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                dormitory.facilities
                    .map(
                      (f) => Chip(
                        label: Text(f),
                        backgroundColor: AppColors.chipBlue,
                        labelStyle: const TextStyle(fontSize: 12),
                      ),
                    )
                    .toList(),
          ),
          if (dormitory.imageUrl != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: Image.network(
                dormitory.imageUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
        if (campusLife != null) ...[
          _buildSectionTitle('Клубууд'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                campusLife.clubs
                    .map(
                      (c) => Chip(
                        label: Text(c),
                        backgroundColor: AppColors.chipPurple,
                        avatar: const Icon(Icons.groups, size: 16),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Дадлагын байгууллагууд'),
          const SizedBox(height: 8),
          ...campusLife.internships.map(
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.business,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(i, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Байгууламж'),
          const SizedBox(height: 8),
          Text(
            campusLife.facilities,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
          if (campusLife.campusImages.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildSectionTitle('Кампусын зургууд'),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: campusLife.campusImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder:
                    (_, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      child: Image.network(
                        campusLife.campusImages[i],
                        width: 280,
                        fit: BoxFit.cover,
                      ),
                    ),
              ),
            ),
          ],
        ],
        const SizedBox(height: 80),
      ],
    );
  }

  // Tab 5: Admission
  Widget _buildAdmissionTab(BuildContext context, String universityId) {
    final admissionInfo = ref.watch(universityAdmissionProvider(universityId));

    if (admissionInfo == null) {
      return const EmptyState(
        title: 'Мэдээлэл байхгүй',
        subtitle: 'Элсэлтийн мэдээлэл одоогоор байхгүй байна',
        icon: Icons.info_outline,
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AdmissionCountdown(admissionInfo: admissionInfo),
        const SizedBox(height: 24),
        _buildSectionTitle('Шаардлагатай баримт бичиг'),
        const SizedBox(height: 12),
        ...admissionInfo.requiredDocuments.map(
          (doc) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 20,
                  color: AppColors.success,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(doc, style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: AppButton.primary(
            'Онлайн бүртгүүлэх',
            onPressed: () => _launchURL(admissionInfo.applyLink),
            expanded: true,
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  // Helper widgets
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

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBookmark(BuildContext context, String universityId) {
    ref.read(bookmarkedUniversitiesProvider.notifier).toggle(universityId);
    final isNowBookmarked = ref
        .read(bookmarkedUniversitiesProvider)
        .contains(universityId);
    showAppSnack(
      context,
      isNowBookmarked ? 'Хадгалагдлаа ✓' : 'Хадгалалтаас хасагдлаа',
    );
  }

  void _handleCompare(BuildContext context, university) {
    ref.read(compareCartProvider.notifier).toggle(university);
    showAppSnack(context, 'Харьцуулалтад нэмэгдлээ');
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
