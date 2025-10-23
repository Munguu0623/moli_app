// lib/features/auth/presentation/widgets/login_mascot.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../shared/design/design_system.dart';

enum MascotState { wave, neutral, error, success }

class LoginMascot extends StatelessWidget {
  final MascotState state;
  final double size;

  const LoginMascot({
    super.key,
    this.state = MascotState.wave,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.primary.withOpacity(0.0),
          ],
        ),
      ),
      child: Center(child: _buildMascotContent()),
    );
  }

  Widget _buildMascotContent() {
    // MOli mascot зураг
    Widget mascot = Image.asset(
      'assets/images/moli_welcome.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );

    return mascot;
  }
}
