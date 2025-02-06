import 'package:flutter/material.dart';

class BluetoothScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("블루투스 기기 탐색")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bluetooth_searching, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text("블루투스 기기를 검색 중...", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.blue), // 로딩 아이콘
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // 블루투스 기기 검색 로직 추가
              },
              child: Text("검색 시작"),
            ),
          ],
        ),
      ),
    );
  }
}
