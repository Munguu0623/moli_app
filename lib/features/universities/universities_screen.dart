// lib/screens/universities_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/design/atoms/filters/university_filter.dart';
import '../../shared/design/atoms/filters/university_filter_controller.dart';
import '../../shared/design/atoms/search_field.dart';
import '../../shared/design/atoms/filters/active_filter_chips.dart';
import '../../shared/design/atoms/filters/university_filter_sheet.dart';
import '../../shared/design/molecules/compare_drawer.dart';
import '../../features/universities/compare_screen.dart';

final selectedCompareProvider = StateProvider<List<String>>(
  (_) => [],
); // school ids or names

class UniversitiesScreen extends ConsumerWidget {
  final bool showAppBar;

  const UniversitiesScreen({super.key, this.showAppBar = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = ref.watch(universityFilterProvider);
    final ctrl = ref.read(universityFilterProvider.notifier);
    final selected = ref.watch(selectedCompareProvider);

    void toggleSelect(String id) {
      final list = [...selected];
      list.contains(id) ? list.remove(id) : list.add(id);
      ref.read(selectedCompareProvider.notifier).state =
          list.take(3).toList(); // 3 хүртэл
    }

    return Scaffold(
      appBar: showAppBar ? AppBar(title: const Text('Их сургуулиуд')) : null,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            children: [
              SearchBarWithFilter(
                hint: 'Сургуулийн нэр эсвэл чиглэлээр хайх',
                onChanged:
                    (value) => ctrl.state = ctrl.state.copyWith(keyword: value),
                onOpenFilter: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder:
                        (_) => UniversityFilterSheet(
                          initial: f,
                          onApply:
                              (nf) =>
                                  ref
                                      .read(universityFilterProvider.notifier)
                                      .state = nf,
                        ),
                  );
                },
              ),
              const SizedBox(height: 10),
              ActiveFilterChips(
                f: f,
                onClear: () => ctrl.state = const UniversityFilter(),
              ),
              const SizedBox(height: 12),

              // TODO: API-аас жагсаалт татна
              for (final uni in ['МУИС', 'СЭЗИС', 'ШУТИС', 'МУБИС'])
                ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.school)),
                  title: Text(uni),
                  subtitle: const Text('Улаанбаатар • 5,200,000₮ • Босго: 650'),
                  trailing: Checkbox(
                    value: selected.contains(uni),
                    onChanged: (_) => toggleSelect(uni),
                  ),
                  onTap: () => toggleSelect(uni),
                ),
            ],
          ),

          // Compare Drawer
          Align(
            alignment: Alignment.bottomCenter,
            child: CompareDrawer(
              items: selected,
              onClear:
                  () => ref.read(selectedCompareProvider.notifier).state = [],
              onCompare: () {
                if (selected.length < 2) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Хоёр ба түүнээс дээш сургууль сонгоно уу'),
                    ),
                  );
                  return;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CompareScreen(universities: selected),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
