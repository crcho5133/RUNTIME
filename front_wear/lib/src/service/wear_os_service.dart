import 'dart:convert';
import 'dart:developer';

import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';

class ConnectService {
  ConnectService._();

  static final instance = ConnectService._();

  final FlutterWearOsConnectivity _flutterWearOsConnectivity =
      FlutterWearOsConnectivity()..configureWearableAPI();

  String message = "";

  void listen() {
    _flutterWearOsConnectivity.messageReceived().listen((wearMessage) {
      inspect(wearMessage);
      message = utf8.decode(wearMessage.data);
    });
  }
}
