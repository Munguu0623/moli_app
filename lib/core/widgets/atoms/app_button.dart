// lib/ui/atoms/app_button.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

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
    final isDisabled = onPressed == null;
    BoxDecoration? deco;
    Color? textColor;

    switch (type) {
      case AppButtonType.primary:
        deco = BoxDecoration(
          gradient: isDisabled ? null : AppGradients.brand,
          color: isDisabled ? AppColors.border.withOpacity(0.5) : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppRadius.button),
          ),
          boxShadow:
              isDisabled
                  ? null
                  : const [
                    BoxShadow(
                      color: Color(0x1F4A6CF7),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
        );
        textColor = isDisabled ? AppColors.textTertiary : Colors.white;
        break;
      case AppButtonType.secondary:
        deco = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.button),
          border: Border.all(
            color: isDisabled ? AppColors.border : AppColors.primary,
            width: 1.4,
          ),
        );
        textColor = isDisabled ? AppColors.textTertiary : AppColors.primary;
        break;
      case AppButtonType.ghost:
        deco = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.button),
        );
        textColor =
            isDisabled ? AppColors.textTertiary : AppColors.textSecondary;
        break;
      case AppButtonType.icon:
        textColor = isDisabled ? AppColors.textTertiary : AppColors.textPrimary;
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
          textAlign: TextAlign.center,
          child:
              type == AppButtonType.icon
                  ? Icon(icon, color: textColor)
                  : Text(label!),
        ),
      ),
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
