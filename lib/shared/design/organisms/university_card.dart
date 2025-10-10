// lib/ui/organisms/university_card.dart
import 'package:flutter/material.dart';
import '../design_system.dart';
import '../atoms/app_card.dart';
import '../atoms/badges.dart';

class UniversityCard extends StatelessWidget {
  final String logoUrl;
  final String name;
  final String location;
  final String tuition;
  final int programs;

  const UniversityCard({
    super.key,
    required this.logoUrl,
    required this.name,
    required this.location,
    required this.tuition,
    required this.programs,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 280,
        child: AppCard(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.chipBlue,
                child: ClipOval(
                  child: Image.network(
                    logoUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.school,
                        size: 32,
                        color: AppColors.primary,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const VerifiedBadge(size: 14),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$location • $tuition / жил',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Хөтөлбөр: $programs',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
