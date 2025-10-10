import 'package:flutter/material.dart';
import '../design_system.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime time;
  final bool showTime;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
    this.showTime = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? AppColors.primary.withOpacity(.12) : AppColors.surface;
    final fg = AppColors.textPrimary;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: isMe ? 64 : 0,
            right: isMe ? 0 : 64,
            top: 6,
            bottom: 2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(14),
              topRight: const Radius.circular(14),
              bottomLeft: Radius.circular(isMe ? 14 : 2),
              bottomRight: Radius.circular(isMe ? 2 : 14),
            ),
            boxShadow: AppShadows.card,
          ),
          child: Text(text, style: TextStyle(color: fg)),
        ),
        if (showTime)
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              _fmt(time),
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }

  String _fmt(DateTime t) =>
      '${t.hour.toString().padLeft(2, "0")}:${t.minute.toString().padLeft(2, "0")}';
}
