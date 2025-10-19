// lib/features/advisors/presentation/consultation_chat_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/molecules/chat_bubble.dart';
import '../../../core/widgets/molecules/chat_input_bar.dart';
import '../../../core/widgets/molecules/consultation_feedback.dart';
import '../../../shared/design/design_system.dart';
import '../application/advisors_provider.dart';
import '../domain/models/chat_message.dart';
import '../domain/models/consultation_booking.dart';

/// Зөвлөгөөний чат screen (UI only, mock messages)
class ConsultationChatScreen extends ConsumerStatefulWidget {
  final ConsultationBooking booking;

  const ConsultationChatScreen({super.key, required this.booking});

  @override
  ConsumerState<ConsultationChatScreen> createState() =>
      _ConsultationChatScreenState();
}

class _ConsultationChatScreenState
    extends ConsumerState<ConsultationChatScreen> {
  late List<ChatMessage> _messages;
  late Timer _timer;
  late Duration _remainingTime;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages = ref.read(chatMessagesProvider(widget.booking.advisorId));
    _remainingTime = const Duration(minutes: 18); // Mock remaining time

    // Timer for countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime -= const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        _showFeedbackSheet();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.booking.advisorName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _formatDuration(_remainingTime),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showTime =
                    index == 0 ||
                    message.timestamp
                            .difference(_messages[index - 1].timestamp)
                            .inMinutes >
                        5;

                return ChatBubble(
                  text: message.text,
                  isMe: message.isMe,
                  time: message.timestamp,
                  showTime: showTime,
                );
              },
            ),
          ),

          // Input bar
          ChatInputBar(
            onSend: (text) {
              setState(() {
                _messages.add(
                  ChatMessage(
                    id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
                    senderId: 'student_001',
                    text: text,
                    timestamp: DateTime.now(),
                    isMe: true,
                  ),
                );
              });

              // Scroll to bottom
              Future.delayed(const Duration(milliseconds: 100), () {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showEndSessionDialog,
        backgroundColor: AppColors.error,
        icon: const Icon(Icons.close_rounded),
        label: const Text(
          'Дуусгах',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _showEndSessionDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              'Зөвлөгөө дуусгах уу?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            content: const Text(
              'Та зөвлөгөөгөө дуусгахдаа итгэлтэй байна уу?',
              style: TextStyle(fontSize: 15),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Үгүй',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _timer.cancel();
                  _showFeedbackSheet();
                },
                style: FilledButton.styleFrom(backgroundColor: AppColors.error),
                child: const Text(
                  'Тийм',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
    );
  }

  void _showFeedbackSheet() {
    // Mark booking as completed
    ref
        .read(myBookingsProvider.notifier)
        .updateStatus(widget.booking.id, BookingStatus.completed);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: ConsultationFeedback(
                session: ConsultationSession(
                  advisorName: widget.booking.advisorName,
                  advisorAvatar: widget.booking.advisorImageUrl,
                  date: widget.booking.scheduledTime,
                  duration: const Duration(minutes: 20),
                  topic: widget.booking.topic ?? 'Ерөнхий зөвлөгөө',
                ),
                onSubmit: (rating, comment) {
                  // In real app, save to backend
                  debugPrint('Rating: $rating, Comment: $comment');
                },
                onCancel: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Go back to previous screen
                },
              ),
            ),
          ),
    ).then((_) {
      // After feedback sheet closes, go back
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }
}
