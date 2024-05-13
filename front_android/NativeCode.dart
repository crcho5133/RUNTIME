// import 'package:flutter/services.dart'
// class NativeCode {
//   static const platform = MethodChannel('com.ssafy.front_android/bluetooth');
//
//   static Future<void> enableBluetooth() async {
//     try {
//       final bool result = await platform.invokeMethod('enableBluetooth');
//       if (result) {
//         print("Bluetooth is enabled");
//       } else {
//         print("Failed to enable bluetooth");
//       }
//     } on PlatformException catch (e) {
//       print("Failed to enable bluetooth: '${e.message}'");
//     }
//   }
//
//   class NativeBridge {
//   static const MethodChannel _channel = MethodChannel('com.example.app/native');
//
//   static Future<String> getNativeData() async {
//   final String result = await _channel.invokeMethod('getNativeData');
//   return result;
//   }
//   }
// }