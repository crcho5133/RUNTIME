import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_wear/src/view/wearable/battle/battle_main.dart';
import 'package:front_wear/src/view/wearable/battle/battle_page.dart';
import 'package:front_wear/src/view/wearable/practice/practice_page.dart';
import 'package:front_wear/src/view/wearable/user/user_page.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/battle_page': (context) => const BattlePage(),
      //   '/user_page': (context) => const UserPage(),
      //   '/practice_page': (context) => const PracticePage(),
      // },
      debugShowCheckedModeBanner: false,
      home: BattleMain(),
    );
  }
}
