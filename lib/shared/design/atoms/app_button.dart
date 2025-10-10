// lib/ui/atoms/app_button.dart
import 'package:flutter/material.dart';
import '../design_system.dart';

enum AppButtonType { primary, secondary, ghost, icon }

class AppButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final IconData? icon;
  final bool expanded;

  const AppButton.primary(
    this.label, {
    super.key,
    this.onPressed,
    this.expanded = false,
  }) : type = AppButtonType.primary,
       icon = null;
  const AppButton.secondary(
    this.label, {
    super.key,
    this.onPressed,
    this.expanded = false,
  }) : type = AppButtonType.secondary,
       icon = null;
  const AppButton.ghost(
    this.label, {
    super.key,
    this.onPressed,
    this.expanded = false,
  }) : type = AppButtonType.ghost,
       icon = null;
  const AppButton.icon(this.icon, {super.key, this.onPressed})
    : type = AppButtonType.icon,
      label = null,
      expanded = false;

  @override
  Widget build(BuildContext context) {
    final child = switch (type) {
      AppButtonType.icon => Icon(icon, color: AppColors.textPrimary),
      _ => Text(label!, style: const TextStyle(color: Colors.white)),
    };

    BoxDecoration? deco;
    Color? textColor;

    switch (type) {
      case AppButtonType.primary:
        deco = const BoxDecoration(
          gradient: AppGradients.brand,
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.button)),
          boxShadow: [
            BoxShadow(
              color: Color(0x1F4A6CF7),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        );
        textColor = Colors.white;
        break;
      case AppButtonType.secondary:
        deco = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.button),
          border: Border.all(color: AppColors.primary, width: 1.4),
        );
        textColor = AppColors.primary;
        break;
      case AppButtonType.ghost:
        deco = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.button),
        );
        textColor = AppColors.textSecondary;
        break;
      case AppButtonType.icon:
        break;
    }

    final button = InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: Ink(
        decoration: deco,
        padding:
            type == AppButtonType.icon
                ? const EdgeInsets.all(10)
                : const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [if (type == AppButtonType.icon) child else child],
          ),
        ),
      ),
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
