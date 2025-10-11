// lib/ui/molecules/compare_drawer.dart
import 'package:flutter/material.dart';
import '../atoms/app_button.dart';
import '../../../shared/design/design_system.dart';

class CompareDrawer extends StatelessWidget {
  final List<String> items; // school names or ids
  final VoidCallback onCompare;
  final VoidCallback onClear;
  const CompareDrawer({
    super.key,
    required this.items,
    required this.onCompare,
    required this.onClear,
  });

  @override
  Widget build(BuildContext c) => AnimatedSlide(
    duration: const Duration(milliseconds: 200),
    offset: items.isEmpty ? const Offset(0, 1) : Offset.zero,
    child: SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        decoration: const BoxDecoration(color: AppColors.background),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Харьцуулах ${items.length}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(onPressed: onClear, child: const Text('Цэвэрлэх')),
            const SizedBox(width: 8),
            AppButton.primary('→ Харьцуулах', onPressed: onCompare),
          ],
        ),
      ),
    ),
  );
}
