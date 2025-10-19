// lib/features/profile/presentation/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../core/widgets/atoms/states.dart';
import '../application/user_provider.dart';
import '../application/saved_items_provider.dart';
import '../application/consultation_history_provider.dart';
import 'widgets/profile_section_card.dart';
import 'widgets/premium_badge.dart';
import 'widgets/logout_confirmation_dialog.dart';
import 'screens/saved_items_screen.dart';
import 'screens/test_result_detail_screen.dart';
import 'screens/consultation_history_screen.dart';
import 'screens/subscription_screen.dart';

/// Профайл хуудас
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  // Settings toggles
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final savedItemsCount = ref.watch(totalSavedItemsCountProvider);
    final consultationsCount = ref.watch(totalConsultationsCountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Профайл',
        showBackButton: false,
        showNotification: false,
        showProfile: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(user),
            const Gap(24),

            // Sections
            _buildSectionsTitle('Миний мэдээлэл'),
            const Gap(12),

            // Хадгалсан зүйлс
            ProfileSectionCard(
              icon: Icons.bookmark_outline,
              title: 'Хадгалсан зүйлс',
              subtitle:
                  savedItemsCount > 0
                      ? '$savedItemsCount зүйл хадгалсан'
                      : 'Хадгалсан зүйлгүй',
              trailing:
                  savedItemsCount > 0
                      ? _buildCountBadge(savedItemsCount)
                      : null,
              onTap: () => _navigateToSavedItems(context),
            ),
            const Gap(12),

            // Тестийн дүн
            ProfileSectionCard(
              icon: Icons.psychology_outlined,
              title: 'Тестийн дүн',
              subtitle: 'RIASEC - SEC',
              iconColor: AppColors.info,
              onTap: () => _navigateToTestResult(context),
            ),
            const Gap(12),

            // Зөвлөгөө түүх
            ProfileSectionCard(
              icon: Icons.chat_bubble_outline,
              title: 'Зөвлөгөө түүх',
              subtitle:
                  consultationsCount > 0
                      ? '$consultationsCount зөвлөгөө'
                      : 'Зөвлөгөөний түүхгүй',
              iconColor: AppColors.success,
              trailing:
                  consultationsCount > 0
                      ? _buildCountBadge(consultationsCount)
                      : null,
              onTap: () => _navigateToConsultations(context),
            ),
            const Gap(12),

            // Гишүүнчлэл ба төлбөр
            ProfileSectionCard(
              icon: Icons.diamond_outlined,
              title: 'Гишүүнчлэл ба төлбөр',
              subtitle: user.isPremium ? 'Premium идэвхтэй' : 'Free хувилбар',
              iconColor: user.isPremium ? AppColors.primary : AppColors.warning,
              trailing: PremiumBadge(
                isPremium: user.isPremium,
                showIcon: false,
              ),
              onTap: () => _navigateToSubscription(context),
            ),

            const Gap(24),
            _buildSectionsTitle('Тохиргоо'),
            const Gap(12),

            // Тохиргоонууд
            _buildSettingsCard(),

            const Gap(24),

            // Гарах товч
            _buildLogoutButton(),
            const Gap(16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar with edit overlay
          Stack(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.brand,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    user.profileImageUrl != null
                        ? ClipOval(
                          child: Image.network(
                            user.profileImageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                        : const Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.white,
                        ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const Gap(16),

          // Name
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(4),

          // Email
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const Gap(12),

          // Premium badge
          PremiumBadge(isPremium: user.isPremium),
          const Gap(16),

          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleEditProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Профайл засах',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionsTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildCountBadge(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Аппын хэл
          _buildSettingsTile(
            icon: Icons.language,
            title: 'Аппын хэл',
            trailing: const Text(
              'Монгол',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              // TODO: Implement language selector
              showAppSnack(context, 'Хэл солих удахгүй нэмэгдэнэ');
            },
          ),
          const Divider(height: 1, indent: 68),

          // Push мэдэгдэл
          _buildSettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Push мэдэгдэл',
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                showAppSnack(
                  context,
                  value ? 'Мэдэгдэл идэвхтэй' : 'Мэдэгдэл идэвхгүй',
                );
              },
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(height: 1, indent: 68),

          // Dark mode
          _buildSettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark mode',
            trailing: Switch(
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
                showAppSnack(context, 'Dark mode удахгүй нэмэгдэнэ');
              },
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(height: 1, indent: 68),

          // Тусламж
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: 'Тусламж',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
              size: 20,
            ),
            onTap: () {
              showAppSnack(context, 'Тусламж хэсэг удахгүй нэмэгдэнэ');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.textTertiary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.textPrimary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _handleLogout,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(color: AppColors.error, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 20),
            SizedBox(width: 8),
            Text(
              'Гарах',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Navigation handlers
  void _navigateToSavedItems(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const SavedItemsScreen()));
  }

  void _navigateToTestResult(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const TestResultDetailScreen()),
    );
  }

  void _navigateToConsultations(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ConsultationHistoryScreen(),
      ),
    );
  }

  void _navigateToSubscription(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const SubscriptionScreen()));
  }

  void _handleEditProfile() {
    // TODO: Implement edit profile screen
    showAppSnack(context, 'Профайл засах хэсэг удахгүй нэмэгдэнэ');
  }

  Future<void> _handleLogout() async {
    final confirmed = await LogoutConfirmationDialog.show(context);
    if (confirmed == true && mounted) {
      // TODO: Implement actual logout logic
      showAppSnack(context, 'Амжилттай гарлаа');
      // Navigate to login/welcome screen if needed
    }
  }
}
