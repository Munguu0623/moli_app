import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class AppTabs extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> pages;
  final int initialIndex;
  const AppTabs({
    super.key,
    required this.tabs,
    required this.pages,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    assert(tabs.length == pages.length);
    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: TabBar(
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              indicator: BoxDecoration(
                color: AppColors.primary.withOpacity(.12),
                borderRadius: BorderRadius.circular(8),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              tabs: [for (final t in tabs) Tab(text: t)],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: TabBarView(children: pages)),
        ],
      ),
    );
  }
}
