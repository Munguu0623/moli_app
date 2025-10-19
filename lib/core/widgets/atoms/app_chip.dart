// lib/ui/atoms/app_chip.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

enum ChipDemandLevel {
  hot, // 🔥 Маш их эрэлттэй
  trending, // 📈 Өсч байгаа
  stable, // ⭐ Тогтвортой
  normal, // Энгийн
}

class AppChip extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Color? customColor;
  final ChipDemandLevel? demandLevel;
  final String? demandText; // Жишээ: "+45%", "2.5K оюутан"

  const AppChip(
    this.label, {
    super.key,
    this.selected = false,
    this.onTap,
    this.customColor,
    this.demandLevel,
    this.demandText,
  });

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  bool _isPressed = false;

  // Chip-ийн өнгийг хэш функцээр тодорхойлох (consistency-ийн төлөө)
  Color _getChipColor(String label) {
    if (widget.customColor != null) return widget.customColor!;

    // Demand level-ээс хамаарч өнгө сонгох
    if (widget.demandLevel != null) {
      switch (widget.demandLevel!) {
        case ChipDemandLevel.hot:
          return const Color(0xFFFFE5E5); // Улаан пастель
        case ChipDemandLevel.trending:
          return AppColors.chipOrange; // Шар
        case ChipDemandLevel.stable:
          return AppColors.chipGreen; // Ногоон
        case ChipDemandLevel.normal:
          return AppColors.chipBlue;
      }
    }

    final colors = [
      AppColors.chipBlue,
      AppColors.chipPurple,
      AppColors.chipOrange,
      AppColors.chipGreen,
      AppColors.chipPink,
    ];

    // Label-ийн үндсэн дээр өнгө сонгох (үргэлж ижил өнгөтэй байх)
    final index = label.hashCode.abs() % colors.length;
    return colors[index];
  }

  // Demand indicator icon
  String? _getDemandIcon() {
    if (widget.demandLevel == null) return null;
    switch (widget.demandLevel!) {
      case ChipDemandLevel.hot:
        return '🔥';
      case ChipDemandLevel.trending:
        return '📈';
      case ChipDemandLevel.stable:
        return '⭐';
      case ChipDemandLevel.normal:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chipColor = _getChipColor(widget.label);
    final bg = widget.selected ? AppColors.primary : chipColor;
    final fg = widget.selected ? Colors.white : AppColors.textPrimary;
    final demandIcon = _getDemandIcon();
    final hasDemandInfo = demandIcon != null || widget.demandText != null;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: hasDemandInfo ? 14 : 16,
          vertical: hasDemandInfo ? 12 : 10,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border:
              widget.demandLevel == ChipDemandLevel.hot
                  ? Border.all(
                    color: const Color(0xFFFF6B6B).withOpacity(0.3),
                    width: 1.5,
                  )
                  : null,
          boxShadow:
              widget.selected
                  ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : widget.demandLevel == ChipDemandLevel.hot
                  ? [
                    BoxShadow(
                      color: const Color(0xFFFF6B6B).withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ]
                  : _isPressed
                  ? []
                  : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
        ),
        transform: Matrix4.identity()..scale(_isPressed ? 0.96 : 1.0),
        child:
            hasDemandInfo
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (demandIcon != null) ...[
                          Text(
                            demandIcon,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          widget.label,
                          style: TextStyle(
                            color: fg,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                    if (widget.demandText != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.demandText!,
                        style: TextStyle(
                          color:
                              widget.selected
                                  ? Colors.white.withOpacity(0.9)
                                  : AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ],
                )
                : Text(
                  widget.label,
                  style: TextStyle(
                    color: fg,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),
                ),
      ),
    );
  }
}
