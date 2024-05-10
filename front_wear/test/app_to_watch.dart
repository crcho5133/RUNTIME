// Dart 예제: MethodChannel을 사용한 메시지 전송 테스트
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const channel = MethodChannel('com.example.myapp/channel');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'send') {
        return 'Message sent to ${methodCall.arguments}';
      }
      return null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('Send message to native code', () async {
    final String result = await channel.invokeMethod('send', 'Hello, Watch!');
    expect(result, equals('Message sent to Hello, Watch!'));
  });
}
