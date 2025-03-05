import 'package:bluetooth_app/features/tag_management/view/tag_registration_screen.dart';
import 'package:bluetooth_app/test/ble/view/ble_connect_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/test_viewmodel.dart';

class BleTestScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tagViewModel = Provider.of<BleTestViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("(TEST)블루투스 탐색")),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bluetooth_searching, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text("블루투스 기기를 검색하세요", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),

            /// 검색 시작 버튼 (리스트 위로 이동)
            ElevatedButton(
              onPressed:
                  tagViewModel.isScanning ? null : tagViewModel.startScan,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    tagViewModel.isScanning ? Colors.grey : Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(tagViewModel.isScanning ? "검색 중..." : "검색 시작"),
            ),

            SizedBox(height: 20),

            /// 검색 중이면 로딩 아이콘 표시
            if (tagViewModel.isScanning)
              Column(
                children: [
                  CircularProgressIndicator(color: Colors.blue),
                  SizedBox(height: 20),
                ],
              ),

            /// 검색된 기기 리스트 표시
            if (!tagViewModel.isScanning && tagViewModel.scanResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: tagViewModel.scanResults.length,
                  itemBuilder: (context, index) {
                    final device = tagViewModel.scanResults[index].device;
                    return ListTile(
                      title: Text(device.platformName.isNotEmpty
                          ? device.platformName
                          : "Unknown Device"),
                      subtitle: Text(device.remoteId.toString()),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          bool success =
                              await tagViewModel.connectToDevice(device);
                          if (success) {
                            // ✅ 연결 완료 후 '기기 등록 페이지'로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BleConnectScreen(
                                  deviceName: device.platformName,
                                  remoteId: device.remoteId.toString(),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("연결"),
                      ),
                    );
                  },
                ),
              ),

            /// 검색 완료 후 장치가 없을 경우 메시지 표시
            if (!tagViewModel.isScanning && tagViewModel.scanResults.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("검색된 기기가 없습니다.",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ),
          ],
        ),
      ),
    );
  }
}
