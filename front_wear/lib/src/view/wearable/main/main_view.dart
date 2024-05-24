import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_wear/src/view/wearable/mode/main_screen.dart';
import 'package:intl/intl.dart';


class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ProviderScope(
      child: Scaffold(
        body: Column(
          children: [
            //MainScreen(title: title, color: color, btn: btn, nextPage: nextPage)
            Image.asset('assets/image/hedgehog.png'),
            const ClockScreen(),
          ],
        ),
      ),

    );
  }
}

class ClockScreen extends ConsumerStatefulWidget {
  const ClockScreen({super.key});

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends ConsumerState<ClockScreen> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    // 1초 마다 현재 시간을 업데이트
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime =
            DateFormat('yyyy-MM-dd (E)\nHH:mm:ss').format(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _currentTime,
            style: const TextStyle(
              backgroundColor: Colors.yellow,
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
