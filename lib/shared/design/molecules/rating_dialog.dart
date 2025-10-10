import 'package:flutter/material.dart';
import '../design_system.dart';

Future<void> showRatingDialog(
  BuildContext context, {
  required ValueChanged<int> onSubmit,
  ValueChanged<String>? onComment,
}) async {
  int rating = 5;
  final controller = TextEditingController();

  await showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Зөвлөгөөг үнэлэх'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  final sel = (i + 1) <= rating;
                  return IconButton(
                    onPressed: () => rating = i + 1,
                    icon: Icon(
                      Icons.star_rounded,
                      size: 28,
                      color: sel ? AppColors.accent : AppColors.textTertiary,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Сэтгэгдэл…',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Болих'),
            ),
            ElevatedButton(
              onPressed: () {
                onSubmit(rating);
                onComment?.call(controller.text.trim());
                Navigator.pop(context);
              },
              child: const Text('Илгээх'),
            ),
          ],
        ),
  );
}
