// lib/features/home/domain/entities/career.dart
import 'package:flutter/material.dart';

/// Мэргэжлийн entity модель
class Career {
  final String id;
  final String title;
  final String summary;
  final IconData icon;
  final String salary;
  final String outlook; // 📈/⚖️/⬇️

  const Career({
    required this.id,
    required this.title,
    required this.summary,
    required this.icon,
    required this.salary,
    required this.outlook,
  });
}
