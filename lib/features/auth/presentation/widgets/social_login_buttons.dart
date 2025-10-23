// lib/features/auth/presentation/widgets/social_login_buttons.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/login_method.dart';

class SocialLoginButtons extends StatelessWidget {
  final void Function(LoginMethod) onSocialLogin;

  const SocialLoginButtons({super.key, required this.onSocialLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'эсвэл',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
          ],
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              icon: Icons.g_mobiledata,
              label: 'Google',
              onTap: () => onSocialLogin(LoginMethod.google),
            ),
            const Gap(12),
            _SocialButton(
              icon: Icons.apple,
              label: 'Apple',
              onTap: () => onSocialLogin(LoginMethod.apple),
            ),
            const Gap(12),
            _SocialButton(
              icon: Icons.facebook,
              label: 'Facebook',
              onTap: () => onSocialLogin(LoginMethod.facebook),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.button),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const Gap(6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
