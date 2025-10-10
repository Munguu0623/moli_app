import 'package:flutter/material.dart';
import '../design_system.dart';

class AppTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final double maxWidth;
  final EdgeInsets padding;

  const AppTooltip({
    super.key,
    required this.child,
    required this.message,
    this.maxWidth = 260,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      richMessage: WidgetSpan(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.35,
            ),
            child: Padding(padding: padding, child: Text(message)),
          ),
        ),
      ),
      decoration: const ShapeDecoration(
        color: Color(0xFF1E1E1E),
        shape: StadiumBorder(), // зөөлөн дугуй хэлбэр
      ),
      waitDuration: const Duration(milliseconds: 300),
      showDuration: const Duration(seconds: 6),
      child: child,
    );
  }
}

/// Жижиг мэдээллийн icon + tooltip
class InfoTooltipIcon extends StatelessWidget {
  final String message;
  const InfoTooltipIcon(this.message, {super.key});
  @override
  Widget build(BuildContext context) => AppTooltip(
    message: message,
    child: const Icon(
      Icons.info_outline,
      color: AppColors.textSecondary,
      size: 18,
    ),
  );
}
