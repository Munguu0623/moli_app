// lib/features/advisors/presentation/advisors_screen.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';

/// Зөвлөхүүдийн хуудас
class AdvisorsScreen extends StatelessWidget {
  const AdvisorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Зөвлөхүүд'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Зөвлөхүүд',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Удахгүй...',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
