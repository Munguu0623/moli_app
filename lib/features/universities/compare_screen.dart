// lib/screens/compare_screen.dart
import 'package:flutter/material.dart';
import '../../shared/design/organisms/university_compare_table.dart';

class CompareScreen extends StatelessWidget {
  final List<String> universities; // id/name
  const CompareScreen({super.key, required this.universities});

  @override
  Widget build(BuildContext context) {
    // TODO: API-аас universities утгаар нь дэлгэрэнгүйг татаж map хийнэ
    final items =
        universities
            .take(3)
            .map(
              (name) => CompareUniversity(
                name: name,
                logoUrl: 'https://picsum.photos/seed/$name/60/60',
                location: 'УБ',
                tuition: '5,200,000₮',
                entryScore: 650,
                programs: 30,
                dorm: name.hashCode % 2 == 0,
                rating: 4.5,
              ),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Харьцуулах')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [UniversityCompareTable(items: items)],
      ),
    );
  }
}
