import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

enum FitBadgeSize { compact, normal, large }

class FitBadge extends StatelessWidget {
  final int percentage;
  final FitBadgeSize size;
  final String? tooltipText;

  const FitBadge({
    super.key,
    required this.percentage,
    this.size = FitBadgeSize.normal,
    this.tooltipText,
  });

  LinearGradient _getGradient() {
    if (percentage <= 40) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
      );
    } else if (percentage <= 70) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
      );
    } else {
      return AppGradients.success;
    }
  }

  String _getLabel() {
    if (percentage <= 40) {
      return 'Бага';
    } else if (percentage <= 70) {
      return 'Дунд';
    } else {
      return 'Өндөр';
    }
  }

  double _getSize() {
    switch (size) {
      case FitBadgeSize.compact:
        return 60;
      case FitBadgeSize.normal:
        return 80;
      case FitBadgeSize.large:
        return 100;
    }
  }

  double _getFontSize() {
    switch (size) {
      case FitBadgeSize.compact:
        return 18;
      case FitBadgeSize.normal:
        return 24;
      case FitBadgeSize.large:
        return 30;
    }
  }

  double _getLabelFontSize() {
    switch (size) {
      case FitBadgeSize.compact:
        return 10;
      case FitBadgeSize.normal:
        return 12;
      case FitBadgeSize.large:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final badge = Container(
      width: _getSize(),
      height: _getSize(),
      decoration: BoxDecoration(
        gradient: _getGradient(),
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$percentage%',
            style: TextStyle(
              fontSize: _getFontSize(),
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _getLabel(),
            style: TextStyle(
              fontSize: _getLabelFontSize(),
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );

    if (tooltipText != null) {
      return Tooltip(message: tooltipText!, child: badge);
    }

    return badge;
  }
}
