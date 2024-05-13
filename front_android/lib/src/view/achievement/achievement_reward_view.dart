import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:go_router/go_router.dart';

class AchievementRewardView extends ConsumerWidget {
  const AchievementRewardView({
    super.key,
  });

  // 레벨업 정보
  static Map<String, dynamic> data = {
    'name': 'LV.2',
    'characterName': '기르핀',
    'characterImgUrl': 'assets/images/mainCharacter.png',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 도전과제 완료!
                  Text(
                    '도전과제 완료!',
                    style: ref.typo.mainTitle.copyWith(fontSize: 42),
                  ),
                  // LV.2 로 레벨업
                  Row(
                    children: [
                      Text(
                        data['name'],
                        style: ref.typo.headline1
                            .copyWith(color: ref.color.accept),
                      ),
                      Text(
                        ' 로 레벨업!',
                        style: ref.typo.headline1
                            .copyWith(color: ref.palette.gray600),
                      ),
                    ],
                  ),
                ],
              ),

              // 캐릭터 이미지(가운데 정렬)
              Center(
                child: Column(
                  children: [
                    // '캐릭터 잠금 해제' 텍스트
                    Text(
                      '캐릭터 잠금 해제',
                      style: ref.typo.subTitle2
                          .copyWith(color: ref.palette.gray600),
                    ),
                    // 캐릭터 이미지
                    Image.asset(
                      data['characterImgUrl'],
                      width: 200,
                      height: 200,
                    ),
                    // 캐릭터 이름
                    Text(
                      data['characterName'],
                      style: ref.typo.headline1
                          .copyWith(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    // 아래 공간 만들기
                    const SizedBox(height: 50),
                  ],
                ),
              ),

              // 확인 버튼
              Button(
                onPressed: () => context.pop(),
                text: '확인',
                backGroundColor: ref.color.accept,
                fontColor: ref.color.onAccept,
              )
            ],
          ),
        ),
      ),
    );
  }
}