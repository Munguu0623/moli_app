// lib/ui/molecules/notification_sheet.dart
import 'package:flutter/material.dart';
import '../atoms/app_card.dart';

class NotificationSheet extends StatelessWidget {
  final List<String> items;
  const NotificationSheet({super.key, required this.items});
  @override
  Widget build(BuildContext c) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Мэдэгдлүүд',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: AppCard(child: Text(e)),
            ),
          ),
        ],
      ),
    ),
  );
}
