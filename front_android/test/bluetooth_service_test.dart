// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:front_android/src/service/bluetooth_permission_service.dart';
// //import 'bluetooth_permission_service_test.mocks.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// // Mock 클래스 생성
// class MockFlutterBlue extends Mock implements FlutterBlue {}

// @GenerateMocks([FlutterBlue, BluetoothDevice])
// void main() {
//   group('Bluetooth Service Tests', () {
//     late MockFlutterBlue mockFlutterBlue;
//     late BluetoothPermissionService service;

//     setUp(() {
//       mockFlutterBlue = MockFlutterBlue();
//       service = BluetoothPermissionService(flutterBlue: mockFlutterBlue);
//     });

//     test('Start scanning for devices', () {
//       when(mockFlutterBlue.startScan(timeout: any))
//           .thenAnswer((_) async => null);
//       service.startScan();
//       verify(mockFlutterBlue.startScan(timeout: any)).called(1);
//     });

//     test('Connect to a device', () async {
//       var mockDevice = MockBluetoothDevice();
//       when(mockFlutterBlue.connect(mockDevice)).thenAnswer((_) async => null);
//       await service.connectToDevice(mockDevice);
//       verify(mockFlutterBlue.connect(mockDevice)).called(1);
//     });
//   });
// }


// // import 'package:flutter_blue/flutter_blue.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:front_android/src/service/bluetooth_permission_service.dart';
// // import 'package:mockito/annotations.dart';
// // import 'package:mockito/mockito.dart';

// // // Mock 클래스 생성
// // //class MockFlutterBlue extends Mock implements FlutterBlue {}

// // @GenerateMocks([FlutterBlue])
// // void main() {
// //   // group('Bluetooth Service Tests', () {
// //   late MockFlutterBlue mockFlutterBlue;
// //   late BluetoothPermissionService service;

// //   setUp(() {
// //     mockFlutterBlue = MockFlutterBlue();
// //     service = BluetoothPermissionService(flutterBlue: mockFlutterBlue);
// //   });

// //   test('Start scanning for devices', () {
// //     // 스캔 시작 명령을 시뮬레이션
// //     when(mockFlutterBlue.startScan(timeout: anyNamed('timeout')))
// //         .thenAnswer((_) async => null);

// //     service.startScan();
// //     // verify that startScan was called on the mock
// //     verify(mockFlutterBlue.startScan(timeout: anyNamed('timeout'))).called(1);
// //   });

// //   test('Connect to a device', () async {
// //     BluetoothDevice device = BluetoothDevice(id: DeviceIdentifier('device_id'));
// //     when(mockFlutterBlue.connect(device)).thenAnswer((_) async => null);

// //     await service.connectToDevice(device);
// //     verify(mockFlutterBlue.connect(device)).called(1);
// //   });
// // }
