import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/home_viewmodel.dart';

class BluetoothScanBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final isScanning = homeViewModel.isScanning;
    final scanResults = homeViewModel.scanResults;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// ✅ 검색 중이면 로딩 아이콘 표시
          if (isScanning) ...[
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 20),
            Text("검색 중...", style: TextStyle(fontSize: 14, color: Colors.grey)),
          ] else ...[
            ElevatedButton(
              onPressed: () => homeViewModel.startScan(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("검색"),
            ),
          ],

          SizedBox(height: 20),

          /// ✅ 검색된 장치 리스트
          if (!isScanning && scanResults.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: scanResults.length,
                itemBuilder: (context, index) {
                  final device = scanResults[index].device;
                  return ListTile(
                    title: Text(device.platformName.isNotEmpty
                        ? device.platformName
                        : "Unknown Device"),
                    subtitle: Text(device.remoteId.toString()),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // TODO: 디바이스랑 연결 코드
                        // homeViewModel.connectToDevice(device);
                      },
                      child: Text("연결"),
                    ),
                  );
                },
              ),
            ),

          /// ✅ 검색 완료 후 장치가 없을 경우
          if (!isScanning && scanResults.isEmpty) ...[
            SizedBox(height: 10),
            Text("검색된 장치가 없습니다.",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ],
      ),
    );
  }
}
