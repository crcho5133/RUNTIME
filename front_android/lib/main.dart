import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_android/src/repository/secure_storage_repository.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:front_android/src/service/bluetooth_permission_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/lang_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/router.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  // Kakao SDK
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"),
    javaScriptAppKey: dotenv.get("KAKAO_JAVASCRIPT_KEY"),
  );

  // 초기 경로 값
  String initialRoute = '/main';

  // 인터셉터
  apiInstance.interceptors.add(CustomInterceptor(
    authService: AuthService.instance,
  ));

  // refreshToken이 있는지 확인
  try {
    final refreshToken = await SecureStorageRepository.instance.refreshToken;
    if (refreshToken == null) {
      initialRoute = '/login';
    } else {
      try {
        var response = await apiInstance.get('api/members');
        var data = response.data;
        var userService = UserService.instance;
        userService.nickname = data['nickname'] ?? '';
        userService.characterImgUrl = data['characterImgUrl'] ?? '';
        userService.weight = data['weight'] ?? '';
        await UserService.instance.getUserInfor();
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  } catch (error) {
    debugPrint(error.toString());
  }

  var key = await KakaoSdk.origin;
  print(key);

  // runApp(ProviderScope(child: MyApp(initialRoute: initialRoute)));

  var bluetoothService = BluetoothPermissionService();
  bluetoothService.startScan();

  runApp(ProviderScope(
      child: MyApp(
    bluetoothService: bluetoothService,
    initialRoute: initialRoute,
  )));
}

class MyApp extends ConsumerWidget {
  final BluetoothPermissionService bluetoothService;

  //const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  MyApp({
    super.key,
    required this.bluetoothService,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ref.themeService.themeDate,
      locale: ref.locale,

      // 오버레이를 사용하기 위해 builder 사용
      // builder: (context, child) {
      //   return Overlay(
      //     initialEntries: [
      //       OverlayEntry(
      //         builder: (context) => child!,
      //       )
      //     ],
      //   );
      // },

      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) =>
                  BluetoothApp(bluetoothService: bluetoothService),
            ),
          ],
        );
      },
    );
  }
}

// 루트 네비게이터 키

class BluetoothApp extends StatefulWidget {
  final BluetoothPermissionService bluetoothService;

  BluetoothApp({required this.bluetoothService});

  @override
  _BluetoothAppState createState() => _BluetoothAppState();
}

class _BluetoothAppState extends State<BluetoothApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Blue Example"),
      ),
      body: ListView.builder(
        itemCount: widget.bluetoothService.getDevices().length,
        itemBuilder: (context, index) {
          var device = widget.bluetoothService.getDevices()[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text(device.id.toString()),
            onTap: () => widget.bluetoothService.connectToDevice(device),
          );
        },
      ),
    );
  }
}
