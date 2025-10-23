// lib/features/auth/presentation/otp_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../../../core/widgets/atoms/app_text_field.dart';
import '../domain/models/auth_state.dart';
import '../application/auth_provider.dart';
import '../application/login_form_provider.dart';
import 'widgets/glassmorphism_card.dart';
import 'widgets/login_mascot.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phone;

  const OtpVerificationScreen({super.key, required this.phone});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  MascotState _mascotState = MascotState.neutral;

  @override
  void initState() {
    super.initState();
    // Start timer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(otpTimerProvider.notifier).startTimer();
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _handleVerify() {
    final otp = _otpController.text.trim();

    if (otp.isEmpty || otp.length != 4) {
      ref.read(otpValidationProvider.notifier).state =
          '4 оронтой код оруулна уу';
      return;
    }

    ref.read(otpValidationProvider.notifier).state = null;
    ref.read(authProvider.notifier).verifyOtp(widget.phone, otp);
  }

  void _handleResend() {
    final remainingTime = ref.read(otpTimerProvider);

    if (remainingTime > 0) return;

    // Resend OTP
    ref
        .read(authProvider.notifier)
        .loginWithPhone(widget.phone.replaceAll('+976', ''));

    // Restart timer
    ref.read(otpTimerProvider.notifier).startTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Баталгаажуулах код дахин илгээгдлээ'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final otpError = ref.watch(otpValidationProvider);
    final remainingTime = ref.watch(otpTimerProvider);

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
        otpSent: (phone) {},
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
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Gap(20),

                      // Mascot
                      LoginMascot(state: _mascotState, size: 160)
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .scale(
                            begin: const Offset(0.8, 0.8),
                            duration: 600.ms,
                          ),

                      const Gap(24),

                      // Title
                      const Text(
                            'Баталгаажуулах код',
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

                      // Subtitle
                      Text(
                        '${widget.phone} дугаарт илгээсэн\n4 оронтой кодыг оруулна уу',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 600.ms, delay: 300.ms),

                      const Gap(32),

                      // OTP Input Card
                      GlassmorphismCard(
                            child: Column(
                              children: [
                                AppTextField(
                                  controller: _otpController,
                                  hint: '1234',
                                  keyboardType: TextInputType.number,
                                  glassmorphism: true,
                                  maxLength: 4,
                                  errorText: otpError,
                                  onChanged: (value) {
                                    ref
                                        .read(otpValidationProvider.notifier)
                                        .state = null;
                                  },
                                ),

                                const Gap(20),

                                // Timer / Resend
                                if (remainingTime > 0)
                                  Text(
                                    'Дахин илгээх: $remainingTime секунд',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  )
                                else
                                  TextButton(
                                    onPressed: _handleResend,
                                    child: const Text(
                                      'Код дахин илгээх',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),

                                const Gap(20),

                                // Verify Button
                                AppButton.primary(
                                  isLoading
                                      ? 'Шалгаж байна...'
                                      : 'Баталгаажуулах',
                                  expanded: true,
                                  onPressed: isLoading ? null : _handleVerify,
                                ),
                              ],
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
