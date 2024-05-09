import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_wear/src/service/theme_service.dart';
import 'package:front_wear/src/view/wearable/battle/battle_main.dart';

class BattlePage extends ConsumerStatefulWidget {
  const BattlePage({super.key});

  @override
  _BattlePageState createState() => _BattlePageState();
}

class _BattlePageState extends ConsumerState<BattlePage> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _elapsedTime = '00:00';

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _startStopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          _elapsedTime = _formatElapsedTime(_stopwatch.elapsedMilliseconds);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  String _formatElapsedTime(int milliseconds) {
    final int hundreds = (milliseconds / 10).truncate();
    final int seconds = (hundreds / 100).truncate();
    final int minutes = (seconds / 60).truncate();
    //final int hours = (minutes / 60).truncate();

    //final String hoursStr = (hours % 24).toString().padLeft(2, '0');
    final String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
  }

  void _stopStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BattleMain()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '상대를 찾는 중..',
              style: ref.typo.body2,
            ),
            Text(
              _elapsedTime,
              style: ref.typo.ranking,
            ),
            // const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _stopStopwatch,
              child: Stack(
                // 위젯 겹치기 위해
                alignment: Alignment.center, // 증앙 배치
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ref.color.wDeny,
                    ),
                  ),
                  SvgPicture.asset(
                    // icon 사용
                    'assets/icons/Cancel.svg',
                    width: 7,
                    height: 7,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
