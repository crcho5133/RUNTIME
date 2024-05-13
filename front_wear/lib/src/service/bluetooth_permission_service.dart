import 'package:flutter_blue/flutter_blue.dart';

class BluetoothPermissionService {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];

  BluetoothPermissionService();

  void startScan() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devicesList.any((device) => device.id == result.device.id)) {
          devicesList.add(result.device);
        }
      }
    });

    flutterBlue.stopScan();
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    // 추가적인 연결 관리 로직
  }

  List<BluetoothDevice> getDevices() {
    return devicesList;
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';

// class BluetoothPermissionService extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BluetoothApp(),
//     );
//   }
// }

// class BluetoothApp extends StatefulWidget {
//   @override
//   _BluetoothAppState createState() => _BluetoothAppState();
// }

// class _BluetoothAppState extends State<BluetoothApp> {
//   FlutterBlue flutterBlue = FlutterBlue.instance;
//   List<BluetoothDevice> devicesList = [];

//   @override
//   void initState() {
//     super.initState();
//     flutterBlue.startScan(timeout: Duration(seconds: 4));

//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult result in results) {
//         print('${result.device.name} found! rssi: ${result.rssi}');
//         if (!devicesList.any((device) => device.id == result.device.id)) {
//           setState(() {
//             devicesList.add(result.device);
//           });
//         }
//       }
//     });

//     flutterBlue.stopScan();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Blue Example"),
//       ),
//       body: ListView.builder(
//         itemCount: devicesList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(devicesList[index].name),
//             subtitle: Text(devicesList[index].id.toString()),
//             onTap: () async {
//               await devicesList[index].connect();
//               // Handle device connection
//             },
//           );
//         },
//       ),
//     );
//   }
// }
