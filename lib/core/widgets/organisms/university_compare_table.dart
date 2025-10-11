import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';
import '../atoms/app_card.dart';
import '../atoms/badges.dart';

class CompareUniversity {
  final String name;
  final String logoUrl;
  final String location;
  final String tuition; // "5,200,000₮"
  final int entryScore; // 400..800
  final int programs; // 0..n
  final bool dorm; // ✓/✗
  final double rating; // 0..5
  final bool verified;

  CompareUniversity({
    required this.name,
    required this.logoUrl,
    required this.location,
    required this.tuition,
    required this.entryScore,
    required this.programs,
    required this.dorm,
    required this.rating,
    this.verified = true,
  });
}

class UniversityCompareTable extends StatelessWidget {
  final List<CompareUniversity> items; // 2..3
  const UniversityCompareTable({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final cols = items.length.clamp(2, 3);
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 320 + (cols * 220)),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: const FixedColumnWidth(220), // row labels
              for (int i = 1; i <= cols; i++) i: const FixedColumnWidth(220),
            },
            children: [
              _headerRow(items),
              _row('Байршил', items.map((e) => Text(e.location)).toList()),
              _row(
                'Жилийн төлбөр',
                items
                    .map(
                      (e) => Text(
                        e.tuition,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    )
                    .toList(),
              ),
              _row(
                'Элсэлтийн босго',
                items.map((e) => _pill('${e.entryScore}')).toList(),
              ),
              _row(
                'Хөтөлбөрийн тоо',
                items.map((e) => _pill('${e.programs}')).toList(),
              ),
              _row(
                'Дотуур байр',
                items
                    .map(
                      (e) => Icon(
                        e.dorm ? Icons.check_circle : Icons.cancel,
                        color: e.dorm ? AppColors.success : AppColors.error,
                      ),
                    )
                    .toList(),
              ),
              _row('Үнэлгээ', items.map((e) => _stars(e.rating)).toList()),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _headerRow(List<CompareUniversity> items) {
    return TableRow(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Сургууль',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(e.logoUrl),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      if (e.verified) const VerifiedBadge(size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (items.length == 2)
          const SizedBox.shrink(), // гурав дахь багана хоосон байж болно (layout тогтвортой)
      ],
    );
  }

  TableRow _row(String label, List<Widget> cells) {
    // cells урт 2 эсвэл 3
    final pad = const EdgeInsets.symmetric(horizontal: 8, vertical: 12);
    return TableRow(
      children: [
        Padding(
          padding: pad,
          child: Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        ...cells.map((w) => Padding(padding: pad, child: w)),
        if (cells.length == 2) const SizedBox.shrink(),
      ],
    );
  }

  Widget _pill(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _stars(double v) => Row(
    children: List.generate(
      5,
      (i) => Icon(
        Icons.star_rounded,
        size: 16,
        color: (i + 1) <= v.round() ? AppColors.accent : AppColors.textTertiary,
      ),
    ),
  );
}
