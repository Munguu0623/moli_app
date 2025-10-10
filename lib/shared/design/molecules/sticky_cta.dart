// lib/ui/molecules/sticky_cta.dart
import 'package:flutter/material.dart';
import '../atoms/app_button.dart';

class StickyCTA extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const StickyCTA({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: AppButton.primary(label, onPressed: onPressed, expanded: true),
      ),
    );
  }
}
