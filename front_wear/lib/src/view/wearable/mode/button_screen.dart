import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_wear/src/service/theme_service.dart';
import 'package:front_wear/src/view/wearable/battle/battle_page.dart';
import 'package:front_wear/src/view/wearable/mode/custom_elevated_button.dart';

class ButtonScreen extends ConsumerWidget {
  const ButtonScreen({
    super.key,
    required this.title,
    required this.color,
    required this.btn,
  });
  // const CustomElevatedButton({
  //   super.key,
  //   required this.text,
  //   required this.backgroundColor,
  //   required this.textColor,
  //   required this.onPressed,
  //   this.width = 150,
  //   this.height = 60,
  //   this.fontSize = 20,

  // });

  final String title;
  final Color color;
  final String btn;

    // final String text;
    // final Color backgroundColor;
    // final Color textColor;
    // final VoidCallback onPressed;
@override

  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: Scaffold(
        //backgroundColor: ref.color.wBackground,
        appBar: AppBar(
          centerTitle: true, // 타이틀 중앙 배치
          title: Padding(
            padding: const EdgeInsets.only(
              // 상단 여백 추가
              top: 5.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  // 위젯 겹치기 위해
                  alignment: Alignment.center, // 증앙 배치
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                    SvgPicture.asset(
                      // icon 사용
                      'assets/icons/Activity-Yoga.svg',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  title,
                  style: ref.typo.headline1.copyWith(
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          // 여백
          padding: const EdgeInsets.only(top: 15),
          child: Align(
            alignment: Alignment.topCenter, // 버튼 위치
            child: CustomElevatedButton(
              text:btn,
              backgroundColor: color,
              textColor: ref.color.wTextB,

              onPressed: () {
                // 버튼 클릭시 수행할 액션
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BattlePage()),
                );
              }, // 버튼 클릭 이벤트

              //style: ElevatedButton.styleFrom(

                  // 버튼 스타일
                  // padding: // 버튼 패딩 조절
                  //     const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
                  //elevation: 0, // 그림자 없애기
                
                  //fixedSize: const Size(150, 60)),
              // child: Text(
              //   btn,
              //   style: ref.typo.appBarMainTitle.copyWith(
              //     color: ref.color.wTextB,
              //     fontSize: 20,
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
