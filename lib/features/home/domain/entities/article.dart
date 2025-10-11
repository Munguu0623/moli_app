// lib/features/home/domain/entities/article.dart

/// Нийтлэлийн entity модель
class Article {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final DateTime date;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.date,
  });
}

