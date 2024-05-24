import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({
    super.key,
    required this.title,
    required this.color,
    required this.btn,
    required this.nextPage,
  });

  final String title;
  final Color color;
  final String btn;
  final void Function() nextPage;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ProviderScope(
      child: Scaffold(
        body: Row(
          children: [
            Align(
            alignment: Alignment.topCenter, // 버튼 위치
            child: ElevatedButton(
              onPressed: () {
                nextPage();
                
              }, // 버튼 클릭 이벤트

              style: ElevatedButton.styleFrom(

                  // 버튼 스타일
                  // padding: // 버튼 패딩 조절
                  //     const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
                  elevation: 0, // 그림자 없애기
                  backgroundColor: color,
                  fixedSize: const Size(150, 60)),
              child: Text(
                btn,
                // style: ref.typo.appBarMainTitle.copyWith(
                //   color: ref.color.wTextB,
                //   fontSize: 20,
                ),
              ),
            ),
          //),
            // Image.asset('assets/image/hedgehog.png'),
            // const ClockScreen(),
          ],
        ),
      ),

    );
  }
}