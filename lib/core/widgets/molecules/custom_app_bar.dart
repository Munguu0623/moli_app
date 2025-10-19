import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;
  final bool showNotification;
  final bool showProfile;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final String? profileImageUrl;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = false,
    this.onBack,
    this.bottom,
    this.showNotification = true,
    this.showProfile = true,
    this.onNotificationTap,
    this.onProfileTap,
    this.profileImageUrl,
  });

  @override
  Size get preferredSize {
    final height = 56.0 + (bottom?.preferredSize.height ?? 0.0);
    return Size.fromHeight(height);
  }

  @override
  Widget build(BuildContext context) {
    // Notification болон profile widgets үүсгэх
    final defaultActions = <Widget>[];

    if (showNotification) {
      defaultActions.add(
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed:
                  onNotificationTap ??
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Мэдэгдэл хэсэг удахгүй нэмэгдэнэ'),
                      ),
                    );
                  },
            ),
            // Notification badge (шинэ мэдэгдэл байвал)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (showProfile) {
      defaultActions.add(
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 4),
          child: GestureDetector(
            onTap:
                onProfileTap ??
                () {
                  // Profile screen рүү шилжих
                  Navigator.of(context).pushNamed('/profile');
                },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              backgroundImage:
                  profileImageUrl != null
                      ? NetworkImage(profileImageUrl!)
                      : null,
              child:
                  profileImageUrl == null
                      ? const Icon(
                        Icons.person_outline,
                        color: AppColors.primary,
                        size: 20,
                      )
                      : null,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: const Border(
          bottom: BorderSide(color: Colors.transparent, width: 0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading:
            showBackButton
                ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                )
                : leading,
        actions: [...?actions, ...defaultActions],
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
        bottom: bottom,
      ),
    );
  }
}
