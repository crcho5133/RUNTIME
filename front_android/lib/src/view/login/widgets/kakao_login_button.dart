import 'package:flutter/material.dart';
import 'package:front_android/src/service/kakao_service.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton(
    this.locale, {
    super.key,
  });

  final String locale;

  @override
  Widget build(BuildContext context) {
    void onPress() async {
      if (!context.mounted) return;
      try {
        var result = await KakaoService.kakaoLogin();
        Navigator.pushNamed(context, RoutePath.runMain);
      } catch (error) {
        print(error);
      }
    }

    return Semantics(
      button: true,
      label: S.current.kakaoLogin,
      child: GestureDetector(
        onTap: onPress,
        child: PngImage(
          'kakaoLogin_$locale',
        ),
      ),
    );
  }
}
