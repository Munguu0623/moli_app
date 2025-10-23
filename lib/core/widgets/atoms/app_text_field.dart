// lib/core/widgets/atoms/app_text_field.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final int? maxLength;
  final String? errorText;
  final bool glassmorphism;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.maxLength,
    this.errorText,
    this.glassmorphism = false,
  });

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
      errorText: errorText,
      prefixIcon: prefix,
      suffixIcon: suffix,
      filled: true,
      fillColor:
          glassmorphism ? Colors.white.withOpacity(0.1) : AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.button),
        borderSide: BorderSide(
          color:
              glassmorphism ? Colors.white.withOpacity(0.2) : AppColors.border,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.button),
        borderSide: BorderSide(
          color:
              glassmorphism ? Colors.white.withOpacity(0.2) : AppColors.border,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.button),
        borderSide: BorderSide(
          color: glassmorphism ? Colors.white : AppColors.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.button),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.button),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      counterText: '',
    );

    final textField = TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      maxLength: maxLength,
      style: TextStyle(
        color: glassmorphism ? Colors.white : AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: inputDecoration,
    );

    if (glassmorphism) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: textField,
        ),
      );
    }

    return textField;
  }
}
