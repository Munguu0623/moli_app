import 'dart:async';
import 'package:flutter/material.dart';
import '../design_system.dart';

enum CountdownFormat {
  full, // "3 өдөр 4 цаг 12 минут"
  compact, // "3ө 4ц 12м"
  simple, // "3 өдөр үлдсэн"
}

class CountdownBadge extends StatefulWidget {
  final DateTime targetDate;
  final CountdownFormat format;
  final IconData? icon;
  final VoidCallback? onExpire;

  const CountdownBadge({
    super.key,
    required this.targetDate,
    this.format = CountdownFormat.full,
    this.icon,
    this.onExpire,
  });

  @override
  State<CountdownBadge> createState() => _CountdownBadgeState();
}

class _CountdownBadgeState extends State<CountdownBadge> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final remaining = widget.targetDate.difference(now);

    if (remaining.isNegative) {
      setState(() {
        _remaining = Duration.zero;
      });
      _timer.cancel();
      widget.onExpire?.call();
    } else {
      setState(() {
        _remaining = remaining;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  LinearGradient _getGradient() {
    final days = _remaining.inDays;
    if (days > 7) {
      return AppGradients.success;
    } else if (days >= 3) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
      );
    }
  }

  String _formatDuration() {
    if (_remaining.isNegative || _remaining == Duration.zero) {
      return 'Дууссан';
    }

    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    switch (widget.format) {
      case CountdownFormat.full:
        final parts = <String>[];
        if (days > 0) parts.add('$days өдөр');
        if (hours > 0 || days > 0) parts.add('$hours цаг');
        if (days == 0 && minutes > 0) parts.add('$minutes минут');
        if (days == 0 && hours == 0) parts.add('$seconds секунд');
        return parts.join(' ');

      case CountdownFormat.compact:
        final parts = <String>[];
        if (days > 0) parts.add('${days}ө');
        if (hours > 0 || days > 0) parts.add('${hours}ц');
        if (days == 0 && minutes > 0) parts.add('${minutes}м');
        if (days == 0 && hours == 0) parts.add('${seconds}с');
        return parts.join(' ');

      case CountdownFormat.simple:
        if (days > 0) {
          return '$days өдөр үлдсэн';
        } else if (hours > 0) {
          return '$hours цаг үлдсэн';
        } else if (minutes > 0) {
          return '$minutes минут үлдсэн';
        } else {
          return '$seconds секунд үлдсэн';
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = _remaining.isNegative || _remaining == Duration.zero;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient:
            isExpired
                ? const LinearGradient(
                  colors: [Color(0xFF9CA3AF), Color(0xFF6B7280)],
                )
                : _getGradient(),
        borderRadius: BorderRadius.circular(AppRadius.chip),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            Icon(widget.icon, size: 16, color: Colors.white),
            const SizedBox(width: 6),
          ] else ...[
            const Icon(
              Icons.access_time_rounded,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            _formatDuration(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
