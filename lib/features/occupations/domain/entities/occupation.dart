// lib/features/occupations/domain/entities/occupation.dart

import 'skill.dart';

/// Цалингийн мэдээлэл
class SalaryRange {
  final double min;
  final double median;
  final double max;
  final String currency; // ₮, $, € гэх мэт
  final String period; // "сар", "жил"

  const SalaryRange({
    required this.min,
    required this.median,
    required this.max,
    this.currency = '₮',
    this.period = 'сар',
  });

  /// Форматтай цалин харуулах
  String get formattedRange {
    return '${_formatAmount(min)} - ${_formatAmount(max)} $currency/$period';
  }

  String get formattedMedian {
    return '${_formatAmount(median)} $currency/$period';
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(0);
  }
}

/// Ирээдүйн эрэлт/чиг хандлага
enum DemandOutlook {
  growing, // Өсч байгаа
  stable, // Тогтвортой
  declining, // Буурч байгаа
}

/// Ажлын орчин
class WorkContext {
  final String environment; // Оффис, гадаа, эмнэлэг гэх мэт
  final String schedule; // Өдрийн цаг, ээлжийн, уян хатан
  final String physicalDemand; // Хөнгөн, дунд, хүнд
  final bool remoteOption; // Алсаас ажиллах боломжтой эсэх

  const WorkContext({
    required this.environment,
    required this.schedule,
    required this.physicalDemand,
    this.remoteOption = false,
  });
}

/// Карьерын зам/замнал
class CareerPath {
  final String occupationId;
  final String name;
  final String description;
  final int yearsRequired; // Хэдэн жилийн дараа

  const CareerPath({
    required this.occupationId,
    required this.name,
    required this.description,
    required this.yearsRequired,
  });
}

/// Мэргэжил (Occupation) entity
class Occupation {
  final String id;
  final String code; // ISCO code эсвэл custom code
  final String name;
  final String summary; // Товч тайлбар (1-2 мөр)
  final String categoryId; // Чиглэлийн ID
  final SalaryRange salaryRange;
  final DemandOutlook demandOutlook;
  final String? outlookDescription; // Эрэлтийн талаарх нэмэлт тайлбар
  final List<Skill> skillsRequired; // Шаардлагатай ур чадварууд
  final List<String> tasks; // Гол үүрэг
  final WorkContext workContext;
  final int relatedProgramsCount; // Холбогдох хөтөлбөрийн тоо
  final List<CareerPath> careerPaths; // Дараагийн шатны мэргэжлүүд
  final String? imageUrl; // Зураг
  final double? rating; // Рейтинг (хэрэв байвал)
  final int? reviewCount; // Үнэлгээний тоо

  const Occupation({
    required this.id,
    required this.code,
    required this.name,
    required this.summary,
    required this.categoryId,
    required this.salaryRange,
    required this.demandOutlook,
    this.outlookDescription,
    required this.skillsRequired,
    required this.tasks,
    required this.workContext,
    required this.relatedProgramsCount,
    required this.careerPaths,
    this.imageUrl,
    this.rating,
    this.reviewCount,
  });

  /// Outlook-ын монгол нэр
  String get outlookLabel {
    switch (demandOutlook) {
      case DemandOutlook.growing:
        return 'Өсч байгаа';
      case DemandOutlook.stable:
        return 'Тогтвортой';
      case DemandOutlook.declining:
        return 'Буурч байгаа';
    }
  }

  /// Outlook-ын emoji
  String get outlookEmoji {
    switch (demandOutlook) {
      case DemandOutlook.growing:
        return '📈';
      case DemandOutlook.stable:
        return '⚖️';
      case DemandOutlook.declining:
        return '📉';
    }
  }
}
