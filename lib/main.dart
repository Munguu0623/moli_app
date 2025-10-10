import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moli_app/shared/design/demo_home.dart';
import 'package:moli_app/ui_kit.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: false,
      home: const DemoHome(),
    );
  }
}
