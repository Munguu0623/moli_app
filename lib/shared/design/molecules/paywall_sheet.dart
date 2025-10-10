// lib/ui/molecules/paywall_sheet.dart
import 'package:flutter/material.dart';
import '../design_system.dart';
import '../atoms/app_button.dart';

class PaywallSheet extends StatelessWidget {
  final VoidCallback onSubscribe;
  const PaywallSheet({super.key, required this.onSubscribe});

  @override
  Widget build(BuildContext c) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Premium контент',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Видео хичээлүүд, deep-fit тест, зөвлөгөөний хямдрал зэрэг давуу эрхүүдийг нээнэ.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              children: const [
                Icon(Icons.stars, color: AppColors.accent),
                SizedBox(width: 12),
                Expanded(child: Text('Premium — 9,900₮ / сар')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppButton.primary(
            'Гишүүнчлэл авах',
            onPressed: onSubscribe,
            expanded: true,
          ),
        ],
      ),
    ),
  );
}
