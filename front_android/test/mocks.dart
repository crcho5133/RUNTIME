import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBluetoothDevice extends Mock implements BluetoothDevice {
  @override
  Future<String> transmit(String data) =>
      super.noSuchMethod(Invocation.method(#transmit, [data]),
          returnValue: Future.value("Data transmitted successfully"),
          returnValueForMissingStub: Future.value("No data transmitted"));
  bool get isConnected => super.noSuchMethod(Invocation.getter(#isConnected),
      returnValue: false, // 기본값 설정: 연결되지 않은 상태
      returnValueForMissingStub: false);
}

void main() {
  group('Bluetooth Device Tests', () {
    late MockBluetoothDevice mockBluetoothDevice;

    setUp(() {
      // 목 객체 초기화
      mockBluetoothDevice = MockBluetoothDevice();
    });

    test('Test Bluetooth Connection', () async {
      // 연결 시뮬레이션: 연결이 성공적으로 이루어졌다고 가정
      when(mockBluetoothDevice.connect()).thenAnswer((_) async => null);

      // 디바이스 연결 실행
      await mockBluetoothDevice.connect();

      // verify that connect was called on the mock device
      verify(mockBluetoothDevice.connect()).called(1);
    });

    test('Data Transmission Test', () async {
      // 연결 상태를 true로 설정
      when(mockBluetoothDevice.isConnected).thenReturn(true);

      // 데이터 전송 시뮬레이션: 전송 성공을 가정
      when(mockBluetoothDevice.transmit("Hello"))
          .thenAnswer((_) async => 'Data transmitted successfully');

      // 데이터 전송 실행
      var result = await mockBluetoothDevice.transmit("Hello, device!");

      // 결과 검증
      expect(result, equals('Data transmitted successfully'));

      // verify that transmit was called with expected data
      verify(mockBluetoothDevice.transmit("Hello, device!")).called(1);
    });
  });
}
