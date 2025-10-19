// lib/features/home/domain/entities/trending_tag.dart
import '../../../../core/widgets/atoms/app_chip.dart';

class TrendingTag {
  final String label;
  final ChipDemandLevel demandLevel;
  final String? demandText; // Жишээ: "+45% эрэлт", "3.2K оюутан"

  const TrendingTag({
    required this.label,
    required this.demandLevel,
    this.demandText,
  });
}
