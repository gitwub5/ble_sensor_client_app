import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/home_viewmodel.dart';
import 'dart:async';

class BluetoothScanBottomSheet extends StatefulWidget {
  @override
  _BluetoothScanBottomSheetState createState() =>
      _BluetoothScanBottomSheetState();
}

class _BluetoothScanBottomSheetState extends State<BluetoothScanBottomSheet> {
  bool _isLoading = false; // 로딩 상태 변수
  bool _hasScanned = false; // 한 번이라도 검색했는지 여부

  /// 검색 시작 함수
  void _startScan(HomeViewModel homeViewModel) {
    setState(() {
      _isLoading = true;
      _hasScanned = true;
    });

    homeViewModel.startScan();

    // 5초 후 로딩 상태 해제
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

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
          if (!_hasScanned) ...[
            Icon(Icons.bluetooth_searching, size: 30, color: Colors.blue),
            SizedBox(height: 10),
            Text("블루투스 검색", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
          ],

          /// 로딩 아이콘 표시
          if (_isLoading) ...[
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 20),
            Text("검색 중...", style: TextStyle(fontSize: 14, color: Colors.grey)),
          ]

          /// 로딩이 끝나면 검색 버튼 표시
          else ...[
            ElevatedButton(
              onPressed: () => _startScan(homeViewModel),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(_hasScanned ? "재검색" : "검색 시작"),
            ),
          ],

          SizedBox(height: 20),

          /// 검색된 장치 리스트
          if (!_isLoading && homeViewModel.scanResults.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: homeViewModel.scanResults.length,
                itemBuilder: (context, index) {
                  final device = homeViewModel.scanResults[index].device;
                  return ListTile(
                    title: Text(device.platformName.isNotEmpty
                        ? device.platformName
                        : "Unknown Device"),
                    subtitle: Text(device.remoteId.toString()),
                    trailing: ElevatedButton(
                      onPressed: () {
                        homeViewModel.connectToDevice(device);
                      },
                      child: Text("연결"),
                    ),
                  );
                },
              ),
            ),

          /// 검색 완료 후 장치가 없을 경우
          if (!_isLoading && homeViewModel.scanResults.isEmpty) ...[
            SizedBox(height: 10),
            Text("검색된 장치가 없습니다.",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ],
      ),
    );
  }
}
