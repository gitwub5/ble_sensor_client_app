import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tag_viewmodel.dart';

class BluetoothScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tagViewModel = Provider.of<TagViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("블루투스 기기 탐색")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bluetooth_searching, size: 80, color: Colors.blue),
          SizedBox(height: 20),
          Text("블루투스 기기를 검색 중...", style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),

          /// 검색 중이면 로딩 아이콘 표시
          if (tagViewModel.scanResults.isEmpty)
            CircularProgressIndicator(color: Colors.blue),

          SizedBox(height: 30),

          /// 검색된 기기 리스트 표시
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
                    onPressed: () {
                      // tagViewModel.connectToDevice(device);
                    },
                    child: Text("연결"),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),

          /// 검색 시작 버튼
          ElevatedButton(
            onPressed: () {
              tagViewModel.startScan();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text("검색 시작"),
          ),
        ],
      ),
    );
  }
}
