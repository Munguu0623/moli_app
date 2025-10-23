// lib/features/auth/presentation/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../../../core/widgets/atoms/app_text_field.dart';
import '../domain/models/login_method.dart';
import '../domain/models/auth_state.dart';
import '../application/auth_provider.dart';
import '../application/login_form_provider.dart';
import 'widgets/glassmorphism_card.dart';
import 'widgets/login_mascot.dart';
import 'widgets/phone_input_field.dart';
import 'widgets/social_login_buttons.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  MascotState _mascotState = MascotState.wave;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final loginMethod = ref.read(loginMethodProvider);
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    // Validation
    if (phone.isEmpty) {
      ref.read(phoneValidationProvider.notifier).state =
          'Утасны дугаар оруулна уу';
      return;
    }

    if (loginMethod == LoginMethod.password && password.isEmpty) {
      ref.read(passwordValidationProvider.notifier).state =
          'Нууц үг оруулна уу';
      return;
    }

    // Clear previous errors
    ref.read(phoneValidationProvider.notifier).state = null;
    ref.read(passwordValidationProvider.notifier).state = null;

    if (loginMethod == LoginMethod.phone) {
      ref.read(authProvider.notifier).loginWithPhone(phone);
    } else {
      ref.read(authProvider.notifier).loginWithPassword(phone, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final loginMethod = ref.watch(loginMethodProvider);
    final phoneError = ref.watch(phoneValidationProvider);
    final passwordError = ref.watch(passwordValidationProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {
          setState(() => _mascotState = MascotState.neutral);
        },
        authenticated: (userId) {
          setState(() => _mascotState = MascotState.success);
          // Navigate to home
          Future.delayed(const Duration(milliseconds: 800), () {
            if (mounted) {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          });
        },
        unauthenticated: () {},
        otpSent: (phone) {
          setState(() => _mascotState = MascotState.success);
          // Navigate to OTP screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => OtpVerificationScreen(phone: phone),
            ),
          );
        },
        error: (message) {
          setState(() => _mascotState = MascotState.error);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: AppColors.error),
          );
        },
      );
    });

    final isLoading = authState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.brand),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Gap(40),

                // Mascot
                LoginMascot(
                      state: _mascotState,
                      size: 180, // Hero section дээр том харуулах
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.2, end: 0, duration: 600.ms),

                const Gap(24),

                // Tagline
                const Text(
                      'Сайн уу! Moli-д тавтай морил 🤗',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideY(
                      begin: 0.1,
                      end: 0,
                      duration: 600.ms,
                      delay: 200.ms,
                    ),

                const Gap(8),

                const Text(
                  'Ирээдүйгээ хамт тодорхойлцгооё.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms, delay: 300.ms),

                const Gap(32),

                // Login Form Card
                GlassmorphismCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Tab Selector
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _TabButton(
                                      label: 'Утасны дугаар',
                                      selected:
                                          loginMethod == LoginMethod.phone,
                                      onTap: () {
                                        ref
                                            .read(loginMethodProvider.notifier)
                                            .state = LoginMethod.phone;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: _TabButton(
                                      label: 'Нууц үг',
                                      selected:
                                          loginMethod == LoginMethod.password,
                                      onTap: () {
                                        ref
                                            .read(loginMethodProvider.notifier)
                                            .state = LoginMethod.password;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Gap(24),

                            // Phone Input
                            PhoneInputField(
                              controller: _phoneController,
                              glassmorphism: true,
                              errorText: phoneError,
                              onChanged: (value) {
                                ref
                                    .read(phoneValidationProvider.notifier)
                                    .state = null;
                              },
                            ),

                            const Gap(16),

                            // Password Input (conditional)
                            if (loginMethod == LoginMethod.password) ...[
                              AppTextField(
                                controller: _passwordController,
                                hint: 'Нууц үг',
                                obscureText: true,
                                glassmorphism: true,
                                errorText: passwordError,
                                onChanged: (value) {
                                  ref
                                      .read(passwordValidationProvider.notifier)
                                      .state = null;
                                },
                                suffix: const Padding(
                                  padding: EdgeInsets.only(right: 12),
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // TODO: Navigate to forgot password
                                  },
                                  child: const Text(
                                    'Нууц үг мартсан уу?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(8),
                            ] else
                              const Gap(8),

                            // Login Button
                            AppButton.primary(
                              isLoading ? 'Түр хүлээнэ үү...' : 'Нэвтрэх',
                              expanded: true,
                              onPressed: isLoading ? null : _handleLogin,
                            ),

                            const Gap(16),

                            // Register Button
                            AppButton.secondary(
                              'Бүртгүүлэх',
                              expanded: true,
                              onPressed:
                                  isLoading
                                      ? null
                                      : () {
                                        // TODO: Navigate to register
                                      },
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 400.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 600.ms,
                      delay: 400.ms,
                    ),

                const Gap(32),

                // Social Login
                SocialLoginButtons(
                  onSocialLogin: (method) {
                    ref.read(authProvider.notifier).loginWithSocial(method);
                  },
                ).animate().fadeIn(duration: 600.ms, delay: 600.ms),

                const Gap(24),

                // Terms & Privacy
                Text.rich(
                  TextSpan(
                    text: 'Нэвтрэхэд та ',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                    children: [
                      const TextSpan(
                        text: 'үйлчилгээний нөхцөл',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: '-ийг зөвшөөрч байна.'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms, delay: 700.ms),

                const Gap(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.primary : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
