// lib/features/occupations/domain/entities/skill.dart

/// Ур чадварын төрөл
enum SkillType {
  hard, // Хатуу ур чадвар (техникийн)
  soft, // Зөөлөн ур чадвар (харилцаа, удирдлага гэх мэт)
}

/// Ур чадварын түвшин
enum SkillLevel {
  beginner, // Анхан шат
  intermediate, // Дунд шат
  advanced, // Ахисан шат
}

/// Ур чадвар entity
class Skill {
  final String id;
  final String name;
  final SkillType type;
  final SkillLevel level;
  final String? description; // Нэмэлт тайлбар

  const Skill({
    required this.id,
    required this.name,
    required this.type,
    required this.level,
    this.description,
  });

  /// Level-ийн монгол нэр
  String get levelLabel {
    switch (level) {
      case SkillLevel.beginner:
        return 'Анхан шат';
      case SkillLevel.intermediate:
        return 'Дунд шат';
      case SkillLevel.advanced:
        return 'Ахисан шат';
    }
  }

  /// Type-ийн монгол нэр
  String get typeLabel {
    switch (type) {
      case SkillType.hard:
        return 'Техникийн';
      case SkillType.soft:
        return 'Зөөлөн';
    }
  }
}
