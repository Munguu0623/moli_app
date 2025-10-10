import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  String title = 'Баталгаажуулах',
  required String message,
  String cancelText = 'Болих',
  String okText = 'Тийм',
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder:
        (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(cancelText),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(okText),
            ),
          ],
        ),
  );
  return ok ?? false;
}

Future<T?> showAppSheet<T>(
  BuildContext context,
  Widget child, {
  bool scrollControlled = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: scrollControlled,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder:
        (_) => SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 12,
            ),
            child: child,
          ),
        ),
  );
}
