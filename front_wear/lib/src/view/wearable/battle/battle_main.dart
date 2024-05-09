import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_wear/src/service/theme_service.dart';
import 'package:front_wear/src/view/wearable/mode/button_screen.dart';

class BattleMain extends ConsumerWidget {
  const BattleMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonScreen(
      title: '배틀모드',
      color: ref.color.wBattleMode,
      btn: '상대찾기',

      
    );
// void a(){
//        Button(onPress: () => Navigator.pushNamed(context, routeName),) 
//       }
    // return CustomElevatedButton(
    //   text: '상대찾기',
    //   backgroundColor: ref.color.wBattleMode,
    //   textColor: ref.color.wTextB,
    //   onPressed: onPressed,
    // );
  }
}
