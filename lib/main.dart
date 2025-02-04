import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter BLE Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResults = [];
  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  /// 블루투스 장치 검색
  void startScan() {
    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });
  }

  /// 선택한 장치에 연결
  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      connectedDevice = device;
    });

    print('Connected to ${device.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bluetooth BLE Scanner')),
      body: connectedDevice == null
          ? ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (context, index) {
                final device = scanResults[index].device;
                return ListTile(
                  title: Text(
                      device.name.isNotEmpty ? device.name : 'Unknown Device'),
                  subtitle: Text(device.id.id),
                  trailing: ElevatedButton(
                    onPressed: () => connectToDevice(device),
                    child: Text('Connect'),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Connected to: ${connectedDevice!.name}'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await connectedDevice!.disconnect();
                      setState(() {
                        connectedDevice = null;
                      });
                    },
                    child: Text('Disconnect'),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: startScan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
