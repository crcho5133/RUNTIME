import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/repository/user_mode_room_repository.dart';
import 'package:front_android/src/service/user_mode_room_service.dart';
import 'package:front_android/src/view/user_mode/widget/make_room_full_dialog.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:go_router/go_router.dart';

final userModeViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => UserModeViewModel());

class UserModeViewModel with ChangeNotifier {
  List<UserModeRoom> _userModeRoomList = [];

  List<String> tagList = const ['전체', '공개방', '1km', '3km', '5km'];
  Map<String, double> distanceMap = const {'1km': 1, '3km': 3, '5km': 5};
  String tagNow = '전체';

  void changeTag(String tag) {
    assert(tagList.contains(tag));
    tagNow = tag;
    notifyListeners();
  }

  List<UserModeRoom> get userModeRoomList {
    if (tagNow == '전체') {
      return _userModeRoomList;
    } else if (tagNow != "공개방") {
      return _userModeRoomList
          .where((element) => element.distance == distanceMap[tagNow])
          .toList();
    } else {
      return _userModeRoomList;
    }
  }

  final userModeRoomRepository = UserModeRoomRepository();

  bool get canFetchMore => !userModeRoomRepository.hasNext;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getRoomList() async {
    _isLoading = true;
    notifyListeners();

    final results = await Future.wait([
      userModeRoomRepository.getUserModeRoomList(
        lastId: userModeRoomRepository.lastId,
      ),
      Future.delayed(const Duration(milliseconds: 500)),
    ]);
    _userModeRoomList = results[0];

    _isLoading = false;
    notifyListeners();
  }

  void moveToSearch(BuildContext context) {
    context.push(RoutePathHelper.userModeSearch);
  }

  final TextEditingController textController = TextEditingController();
  String get searchWord => textController.text.trim();

  List<UserModeRoom> userModeSearchedList = [];

  Future<void> searchRoomList() async {
    _isLoading = true;
    notifyListeners();

    final results = await Future.wait([
      userModeRoomRepository.getUserModeRoomList(searchWord: searchWord),
      Future.delayed(const Duration(milliseconds: 500)),
    ]);
    userModeSearchedList = results[0];

    _isLoading = false;
    notifyListeners();
  }

  void makeRoomModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const MakeRoomFullDialog();
      },
    );
  }

  final TextEditingController roomNameTextController = TextEditingController();
  String get name => roomNameTextController.text.trim(); // 방 이름

  double _distance = 3; // 목표 거리
  double get distance => _distance;
  void setDistance(double value) {
    switch (value) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        _distance = value;
        notifyListeners();
        break;
    }
  }

  int _capacity = 4; // 정원
  int get capacity => _capacity;
  void setCapacity(double value) {
    if (value <= 5) {
      _capacity = value.toInt();
      notifyListeners();
    }
  }

  final TextEditingController passwordController = TextEditingController();
  String? get password => passwordController.text.trim() == ''
      ? null
      : passwordController.text.trim();
  void onChangeText() {
    notifyListeners();
  }

  UserModeRoomService userModeRoomService = UserModeRoomService();

  Future<UserModeRoom?> makeRoom() async {
    if (name.isEmpty) return null;
    print('fawwfa');
    MakeRoomModel makeRoomModel = MakeRoomModel(
      name: name,
      capacity: capacity,
      distance: distance.toDouble() * 1000,
      password: password,
    );

    var response =
        await userModeRoomService.makeRoom(makeRoomModel: makeRoomModel);

    return response;
  }
}
