// lib/ui/organisms/career_card.dart
import 'package:flutter/material.dart';
import '../atoms/app_card.dart';

class CareerCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String summary;
  final String outlook; // 📈/⚖️/⬇️ гэх мэт
  final String salary;

  const CareerCard({
    super.key,
    required this.icon,
    required this.title,
    required this.summary,
    required this.outlook,
    required this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 260,
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              Text(summary, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(outlook),
                  const Spacer(),
                  Text(
                    '💰 $salary',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
