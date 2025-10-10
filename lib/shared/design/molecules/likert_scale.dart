import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../design_system.dart';

enum LikertLabel { v1, v2, v3, v4, v5 }

class LikertScale extends StatefulWidget {
  final int value; // 1..5
  final ValueChanged<int> onChanged;
  final bool emoji; // true → emoji variant
  final String? leftHint; // "Огт үгүй"
  final String? rightHint; // "Маш их тийм"

  const LikertScale({
    super.key,
    required this.value,
    required this.onChanged,
    this.emoji = true,
    this.leftHint,
    this.rightHint,
  });

  @override
  State<LikertScale> createState() => _LikertScaleState();
}

class _LikertScaleState extends State<LikertScale> {
  late int current;

  @override
  void initState() {
    super.initState();
    current = widget.value;
  }

  void _set(int v) {
    if (v < 1 || v > 5) return;
    HapticFeedback.selectionClick();
    setState(() => current = v);
    widget.onChanged(v);
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(5, (i) => i + 1);

    return Focus(
      autofocus: true,
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): DirectionalFocusIntent(
            TraversalDirection.left,
          ),
          LogicalKeySet(LogicalKeyboardKey.arrowRight): DirectionalFocusIntent(
            TraversalDirection.right,
          ),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
              onInvoke: (intent) {
                if (intent.direction == TraversalDirection.left)
                  _set(current - 1);
                if (intent.direction == TraversalDirection.right)
                  _set(current + 1);
                return null;
              },
            ),
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.leftHint != null)
                    Text(
                      widget.leftHint!,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  if (widget.rightHint != null)
                    Text(
                      widget.rightHint!,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    items.map((i) {
                      final selected = i == current;
                      return _LikertDot(
                        label: widget.emoji ? _emoji(i) : i.toString(),
                        selected: selected,
                        onTap: () => _set(i),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _emoji(int i) => switch (i) {
    1 => '😐',
    2 => '🙂',
    3 => '😊',
    4 => '😃',
    _ => '🤩',
  };
}

class _LikertDot extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _LikertDot({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Likert scale",
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                selected
                    ? AppColors.primary.withOpacity(.12)
                    : AppColors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected ? AppColors.primary : const Color(0xFFE0E0E0),
              width: selected ? 2 : 1,
            ),
            boxShadow: selected ? AppShadows.card : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: label.length == 1 ? 18 : 20,
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
