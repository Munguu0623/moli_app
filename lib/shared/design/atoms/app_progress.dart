import 'package:flutter/material.dart';
import '../design_system.dart';

class AppProgressBar extends StatelessWidget {
  final double value; // 0..1
  const AppProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Stack(
        children: [
          Container(height: 10, color: const Color(0xFFE9ECF2)),
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 10,
            width: MediaQuery.of(context).size.width * value,
            decoration: const BoxDecoration(gradient: AppGradients.brand),
          ),
        ],
      ),
    );
  }
}
