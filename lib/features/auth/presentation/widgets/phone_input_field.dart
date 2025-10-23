// lib/features/auth/presentation/widgets/phone_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/widgets/atoms/app_text_field.dart';
import '../../../../shared/design/design_system.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool glassmorphism;
  final String? errorText;

  const PhoneInputField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.glassmorphism = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      keyboardType: TextInputType.phone,
      errorText: errorText,
      glassmorphism: glassmorphism,
      maxLength: 8,
      prefix: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '+976',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: glassmorphism ? Colors.white : Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 1.5,
              height: 20,
              color:
                  glassmorphism
                      ? Colors.white.withOpacity(0.3)
                      : AppColors.border,
            ),
          ],
        ),
      ),
    );
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Утасны дугаар оруулна уу';
    }
    if (value.length != 8) {
      return '8 оронтой дугаар оруулна уу';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Зөвхөн тоо оруулна уу';
    }
    return null;
  }
}
