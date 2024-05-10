import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:go_router/go_router.dart';

final battleModeProvider =
    ChangeNotifierProvider((ref) => BattleModeViewModel());

class BattleModeViewModel with ChangeNotifier {
  final String tierImage = 'pro_1';

  final String tier = '프로';

  final int _score = 842;
  String get score => _score.toString();

  final int _percent = 13;
  String get percent => _percent.toString();

  void onPress(BuildContext context) {
    context.push(RoutePathHelper.beforeMatching);
  }
}
