import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tag_viewmodel.dart';

class TagRegistrationScreen extends StatelessWidget {
  final String deviceName;
  final String remoteId;

  TagRegistrationScreen({required this.deviceName, required this.remoteId});

  @override
  Widget build(BuildContext context) {
    final tagViewModel = Provider.of<TagViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("기기 등록")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("디바이스 이름: $deviceName",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("BLE ID: $remoteId", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            /// 명령어 전송 버튼
            ElevatedButton(
              onPressed: () {
                tagViewModel.writeData(
                  CommandType.setting,
                  latestTime: DateTime.now(),
                  period: Duration(seconds: 30),
                  name: "pico",
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

            /// 명령어 전송 버튼
            ElevatedButton(
              onPressed: () {
                tagViewModel.writeData(
                  CommandType.update,
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

            /// 연결 해제 버튼
            ElevatedButton(
              onPressed: () {
                tagViewModel.disconnectDevice();
                Navigator.pop(context); // 등록 페이지 닫기
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("해제"),
            ),
          ],
        ),
      ),
    );
  }
}
