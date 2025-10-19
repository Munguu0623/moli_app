// lib/features/universities/presentation/widgets/tuition_calculator_widget.dart

import 'package:flutter/material.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/tuition_info.dart';

/// Төлбөрийн тооцоолуур widget
class TuitionCalculatorWidget extends StatefulWidget {
  final TuitionInfo tuitionInfo;

  const TuitionCalculatorWidget({super.key, required this.tuitionInfo});

  @override
  State<TuitionCalculatorWidget> createState() =>
      _TuitionCalculatorWidgetState();
}

class _TuitionCalculatorWidgetState extends State<TuitionCalculatorWidget> {
  bool includeDorm = false;
  bool includeLiving = true;
  final double monthlyDorm = 150000; // Дунджаар
  final double monthlyLiving = 300000; // Амьжиргаа

  @override
  Widget build(BuildContext context) {
    final tuitionPerYear = _parseMoney(widget.tuitionInfo.perYear);
    final dormPerYear = includeDorm ? monthlyDorm * 9 : 0; // 9 сар
    final livingPerYear = includeLiving ? monthlyLiving * 9 : 0;
    final total = tuitionPerYear + dormPerYear + livingPerYear;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppGradients.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calculate,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Жилийн нийт зардал',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCostRow(
            'Сургалтын төлбөр',
            tuitionPerYear.toDouble(),
            enabled: true,
            onChanged: null,
          ),
          const SizedBox(height: 8),
          _buildCostRow(
            'Дотуур байр (9 сар)',
            dormPerYear.toDouble(),
            enabled: includeDorm,
            onChanged: (v) => setState(() => includeDorm = v),
          ),
          const SizedBox(height: 8),
          _buildCostRow(
            'Амьжиргаа (9 сар)',
            livingPerYear.toDouble(),
            enabled: includeLiving,
            onChanged: (v) => setState(() => includeLiving = v),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Нийт:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${_formatMoney(total.round())}₮',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Сард: ${_formatMoney((total / 12).round())}₮',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(
    String label,
    double amount, {
    required bool enabled,
    ValueChanged<bool>? onChanged,
  }) {
    return Row(
      children: [
        if (onChanged != null)
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: enabled,
              onChanged: (v) => onChanged(v ?? false),
              activeColor: AppColors.primary,
            ),
          ),
        if (onChanged != null) const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: enabled ? AppColors.textPrimary : AppColors.textTertiary,
            ),
          ),
        ),
        Text(
          '${_formatMoney(amount.toInt())}₮',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: enabled ? AppColors.textPrimary : AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  double _parseMoney(String moneyStr) {
    final cleaned = moneyStr.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  String _formatMoney(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
