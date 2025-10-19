// lib/features/profile/domain/models/saved_item.dart

/// Saved item төрөл
enum SavedItemType {
  university,
  occupation,
  article;

  String get label {
    switch (this) {
      case SavedItemType.university:
        return 'Сургууль';
      case SavedItemType.occupation:
        return 'Мэргэжил';
      case SavedItemType.article:
        return 'Нийтлэл';
    }
  }

  String get emoji {
    switch (this) {
      case SavedItemType.university:
        return '🏫';
      case SavedItemType.occupation:
        return '💼';
      case SavedItemType.article:
        return '📰';
    }
  }
}

/// Хадгалсан зүйл
class SavedItem {
  final String id;
  final SavedItemType type;
  final String
  itemId; // Reference to the actual item (university/occupation/article id)
  final DateTime savedAt;

  const SavedItem({
    required this.id,
    required this.type,
    required this.itemId,
    required this.savedAt,
  });

  SavedItem copyWith({
    String? id,
    SavedItemType? type,
    String? itemId,
    DateTime? savedAt,
  }) {
    return SavedItem(
      id: id ?? this.id,
      type: type ?? this.type,
      itemId: itemId ?? this.itemId,
      savedAt: savedAt ?? this.savedAt,
    );
  }
}
