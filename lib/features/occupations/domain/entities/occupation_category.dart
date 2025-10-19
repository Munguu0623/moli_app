// lib/features/occupations/domain/entities/occupation_category.dart

import 'package:flutter/material.dart';

/// Мэргэжлийн чиглэл (IT, Эрүүл мэнд, Бизнес гэх мэт)
class OccupationCategory {
  final String id;
  final String name;
  final IconData icon;
  final String description;
  final int occupationCount; // Энэ чиглэлд хамаарах мэргэжлийн тоо
  final Color color; // Чиглэл бүрийн өнгө

  const OccupationCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.occupationCount,
    required this.color,
  });

  /// Градиент үүсгэх (card дээр ашиглах)
  LinearGradient get gradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [color, color.withOpacity(0.7)],
    );
  }
}
