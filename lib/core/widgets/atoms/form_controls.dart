// lib/ui/atoms/form_controls.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });
  @override
  Widget build(BuildContext c) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (label != null)
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            label!,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
      Switch(
        value: value,
        activeColor: Colors.white,
        activeTrackColor: AppColors.primary,
        onChanged: onChanged,
      ),
    ],
  );
}

class AppSegmented<T> extends StatelessWidget {
  final T value;
  final List<T> options;
  final String Function(T) label;
  final ValueChanged<T> onChanged;
  const AppSegmented({
    super.key,
    required this.value,
    required this.options,
    required this.label,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    child: Row(
      children:
          options.map((o) {
            final sel = o == value;
            return Expanded(
              child: InkWell(
                onTap: () => onChanged(o),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: sel ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      label(o),
                      style: TextStyle(
                        color: sel ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    ),
  );
}

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });
  @override
  Widget build(BuildContext c) => CheckboxListTile(
    value: value,
    onChanged: onChanged,
    dense: true,
    contentPadding: EdgeInsets.zero,
    title: Text(label),
    controlAffinity: ListTileControlAffinity.leading,
  );
}

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String hint;
  final String Function(T) label;
  final ValueChanged<T?> onChanged;
  const AppDropdown({
    super.key,
    this.value,
    required this.items,
    required this.label,
    required this.onChanged,
    this.hint = 'Сонгох',
  });
  @override
  Widget build(BuildContext c) => DropdownButtonFormField<T>(
    value: value,
    onChanged: onChanged,
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    hint: Text(hint),
    items:
        items
            .map((e) => DropdownMenuItem(value: e, child: Text(label(e))))
            .toList(),
  );
}
