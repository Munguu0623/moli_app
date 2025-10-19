// lib/features/universities/domain/models/tuition_info.dart

/// Санхүүгийн мэдээлэл
class TuitionInfo {
  final String universityId;
  final String perYear; // "5,200,000₮"
  final String perSemester; // "2,600,000₮"
  final String scholarshipInfo; // "GPA 3.5 дээш бол 30% хөнгөлөлт"
  final bool loanAvailable; // Зээл авах боломжтой эсэх
  final String loanConditions; // Зээлийн нөхцөл
  final Map<String, String>
  additionalFees; // Нэмэлт төлбөрүүд (бүртгэл, ном гэх мэт)

  const TuitionInfo({
    required this.universityId,
    required this.perYear,
    required this.perSemester,
    required this.scholarshipInfo,
    required this.loanAvailable,
    required this.loanConditions,
    required this.additionalFees,
  });

  /// Жилийн нийт өртөг (төлбөр + нэмэлт)
  String get estimatedTotal {
    // Mock calculation - жилийн төлбөр + 10%
    final base = int.tryParse(perYear.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
    final total = (base * 1.1).round();
    return '${_formatMoney(total)}₮';
  }

  String _formatMoney(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
