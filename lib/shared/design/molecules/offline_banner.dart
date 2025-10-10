import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../design_system.dart';

class OfflineBanner extends StatefulWidget {
  const OfflineBanner({super.key});
  @override
  State<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<OfflineBanner> {
  late final StreamSubscription _sub;
  bool offline = false;

  @override
  void initState() {
    super.initState();
    _sub = Connectivity().onConnectivityChanged.listen((result) {
      setState(() => offline = result.contains(ConnectivityResult.none));
    });
    // эхний төлөв
    Connectivity().checkConnectivity().then((r) {
      setState(() => offline = r.contains(ConnectivityResult.none));
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!offline) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      color: Colors.orange,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: const Text(
        'Оффлайн горим — сүүлд буусан өгөгдлийг харуулж байна',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
    );
  }
}
