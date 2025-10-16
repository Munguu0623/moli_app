// lib/app/main_navigation.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/tests/presentation/tests_screen.dart';
import '../features/universities/presentation/universities_screen.dart';
import '../features/advisors/presentation/advisors_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../shared/design/design_system.dart';

/// Сонгогдсон tab-ын index
final selectedTabProvider = StateProvider<int>((ref) => 0);

/// Үндсэн navigation экран - Bottom Navigation Bar-тай
class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);

    // Табуудын жагсаалт
    final screens = [
      const HomeScreen(),
      const TestsScreen(),
      const UniversitiesScreen(),
      const AdvisorsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (i) {
                ref.read(selectedTabProvider.notifier).state = i;
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.background,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textTertiary,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
              selectedIconTheme: const IconThemeData(
                size: 26,
                weight: 600,
                opticalSize: 20,
              ),
              unselectedIconTheme: const IconThemeData(
                size: 24,
                weight: 300,
                opticalSize: 20,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Нүүр',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.psychology_outlined),
                  label: 'Тест',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school_outlined),
                  label: 'Сургууль',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  label: 'Зөвлөх',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Профайл',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
