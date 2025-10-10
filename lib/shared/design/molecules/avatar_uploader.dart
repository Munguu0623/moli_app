// lib/ui/molecules/avatar_uploader.dart
import 'package:flutter/material.dart';
import '../design_system.dart';

class AvatarUploader extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onPick;
  const AvatarUploader({super.key, this.imageUrl, required this.onPick});

  @override
  Widget build(BuildContext c) => Stack(
    children: [
      CircleAvatar(
        radius: 48,
        backgroundColor: AppColors.chipBlue,
        child:
            imageUrl != null
                ? ClipOval(
                  child: Image.network(
                    imageUrl!,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        size: 48,
                        color: AppColors.primary,
                      );
                    },
                  ),
                )
                : const Icon(Icons.person, size: 48, color: AppColors.primary),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          child: IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: onPick,
          ),
        ),
      ),
    ],
  );
}
