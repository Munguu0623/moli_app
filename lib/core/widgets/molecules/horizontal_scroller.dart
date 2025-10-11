// lib/ui/molecules/horizontal_scroller.dart
import 'package:flutter/material.dart';

class HorizontalScroller extends StatelessWidget {
  final List<Widget> children;
  const HorizontalScroller({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => children[i],
      ),
    );
  }
}
