// lib/ui/molecules/tuition_calculator.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';
import '../atoms/app_button.dart';

class TuitionCalculator extends StatefulWidget {
  final int baseFee; // ₮
  final int discountPct; // %
  final int prepayPct; // %
  final VoidCallback onPay; // QPay CTA
  const TuitionCalculator({
    super.key,
    required this.baseFee,
    this.discountPct = 0,
    this.prepayPct = 0,
    required this.onPay,
  });

  @override
  State<TuitionCalculator> createState() => _TuitionCalculatorState();
}

class _TuitionCalculatorState extends State<TuitionCalculator> {
  late int discount;
  late int prepay;

  @override
  void initState() {
    super.initState();
    discount = widget.discountPct;
    prepay = widget.prepayPct;
  }

  int get discounted => (widget.baseFee * (100 - discount) / 100).round();
  int get prepayAmount => (discounted * prepay / 100).round();
  int get monthly => ((discounted - prepayAmount) / 10).ceil();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Төлбөрийн тооцоолуур',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          _row('Суурь төлбөр', _m(widget.baseFee)),
          _row('Хөнгөлөлт (%)', '$discount%'),
          Slider(
            value: discount.toDouble(),
            min: 0,
            max: 50,
            divisions: 50,
            onChanged: (v) => setState(() => discount = v.round()),
          ),
          _row('Урьдчилгаа (%)', '$prepay%'),
          Slider(
            value: prepay.toDouble(),
            min: 0,
            max: 50,
            divisions: 50,
            onChanged: (v) => setState(() => prepay = v.round()),
          ),
          const Divider(height: 24),
          _row('Хөнгөлөлттэй үнэ', _m(discounted)),
          _row('Урьдчилгаа', _m(prepayAmount)),
          _row('Үлдэгдэл (10 сар)', '${_m(monthly)} / сар'),
          const SizedBox(height: 12),
          AppButton.primary(
            'QPay-гаар төлөх',
            onPressed: widget.onPay,
            expanded: true,
          ),
        ],
      ),
    );
  }

  Widget _row(String a, String b) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            a,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        Text(b, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    ),
  );

  String _m(int v) => '${_fmt(v)}₮';
  String _fmt(int x) {
    final s = x.toString();
    final b = StringBuffer();
    int c = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      b.write(s[i]);
      c++;
      if (c % 3 == 0 && i != 0) b.write(',');
    }
    return b.toString().split('').reversed.join();
  }
}
