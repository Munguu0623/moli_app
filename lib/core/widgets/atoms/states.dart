// lib/ui/atoms/states.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? action;
  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.inbox,
    this.action,
  });
  @override
  Widget build(BuildContext c) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: AppColors.textTertiary),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          if (action != null) ...[const SizedBox(height: 12), action!],
        ],
      ),
    ),
  );
}

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ErrorState({super.key, required this.message, required this.onRetry});
  @override
  Widget build(BuildContext c) => EmptyState(
    title: 'Алдаа гарлаа',
    subtitle: message,
    icon: Icons.error_outline,
    action: ElevatedButton(
      onPressed: onRetry,
      child: const Text('Дахин оролдох'),
    ),
  );
}

class SkeletonBox extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  const SkeletonBox({
    super.key,
    this.height = 16,
    this.width = double.infinity,
    this.radius = 12,
  });
  @override
  Widget build(BuildContext c) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: const Color(0xFFEDEFF3),
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

// Snackbar helper
void showAppSnack(BuildContext c, String text, {bool success = true}) {
  ScaffoldMessenger.of(c).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: success ? AppColors.success : AppColors.error,
    ),
  );
}
