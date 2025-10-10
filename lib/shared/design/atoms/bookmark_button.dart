// lib/ui/atoms/bookmark_button.dart
import 'package:flutter/material.dart';
import '../design_system.dart';

class BookmarkButton extends StatefulWidget {
  final bool initial;
  final ValueChanged<bool>? onChanged;
  const BookmarkButton({super.key, this.initial = false, this.onChanged});
  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  late bool saved;
  @override
  void initState() {
    super.initState();
    saved = widget.initial;
  }

  @override
  Widget build(BuildContext c) => IconButton(
    onPressed: () {
      setState(() => saved = !saved);
      widget.onChanged?.call(saved);
    },
    icon: Icon(
      saved ? Icons.bookmark : Icons.bookmark_border,
      color: saved ? AppColors.primary : AppColors.textSecondary,
    ),
  );
}
