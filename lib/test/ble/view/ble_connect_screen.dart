import 'dart:async';
import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/test_viewmodel.dart';

class BleConnectScreen extends StatefulWidget {
  final String deviceName;
  final String remoteId;

  BleConnectScreen({required this.deviceName, required this.remoteId});

  @override
  _BleConnectScreenState createState() => _BleConnectScreenState();
}

class _BleConnectScreenState extends State<BleConnectScreen> {
  final List<String> receivedData = []; // 📌 BLE 수신 로그 저장 리스트
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  late final StreamSubscription<String> _bleSubscription;

  @override
  void initState() {
    super.initState();

    // 📌 TX 데이터 구독 - 새로운 데이터 수신 시 리스트에 추가
    _bleSubscription = Provider.of<BleTestViewModel>(context, listen: false)
        .bluetoothManager
        .connectionService
        .stream
        .listen((data) {
      if (!mounted) return;
      setState(() {
        receivedData.add(data);
      });
    });
  }

  /// ✅ 입력된 시간을 `Duration`으로 변환
  Duration _getDurationFromInput() {
    int hours = int.tryParse(_hourController.text) ?? 0;
    int minutes = int.tryParse(_minuteController.text) ?? 0;

    return Duration(hours: hours, minutes: minutes);
  }

  @override
  Widget build(BuildContext context) {
    final testViewModel = Provider.of<BleTestViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("(TEST)기기 연결")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("디바이스 이름: ${widget.deviceName}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("BLE ID: ${widget.remoteId}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            /// 🔹 시/분/초 입력 필드 추가
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _hourController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "시간 (h)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _minuteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "분 (m)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            /// 🔹 등록 버튼
            ElevatedButton(
              onPressed: () {
                Duration period = _getDurationFromInput();
                testViewModel.writeData(
                  commandType: CommandType.setting,
                  latestTime: DateTime.now(),
                  period: period,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("등록"),
            ),

            SizedBox(height: 10),

            /// 🔹 데이터 수신 버튼
            ElevatedButton(
              onPressed: () {
                testViewModel.writeData(
                  commandType: CommandType.update,
                  latestTime: DateTime.now(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("데이터 수신"),
            ),

            SizedBox(height: 10),

            /// 🔹 연결 해제 버튼
            ElevatedButton(
              onPressed: () {
                testViewModel.disconnectDevice();
                Navigator.pop(context); // 등록 페이지 닫기
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("해제"),
            ),

            SizedBox(height: 20),

            /// 📡 **BLE 수신 데이터 로그**
            Text("📡 수신 데이터 로그", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: receivedData.isEmpty
                    ? Center(
                        child: Text("수신된 데이터가 없습니다.",
                            style: TextStyle(color: Colors.white70)))
                    : ListView.builder(
                        itemCount: receivedData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              receivedData[index],
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bleSubscription.cancel();
    receivedData.clear();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }
}
