import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/features/tag_management/tag/view/tag_registration_screen.dart';
import 'package:bluetooth_app/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tag_viewmodel.dart';

class BluetoothScanScreen extends StatefulWidget {
  @override
  _BluetoothScanScreenState createState() => _BluetoothScanScreenState();
}

class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
  @override
  void initState() {
    super.initState();
    // 페이지가 열리면 자동으로 검색을 시작한다.
    Future.microtask(
        () => Provider.of<TagViewModel>(context, listen: false).startScan(
              Duration(seconds: 5),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final tagViewModel = Provider.of<TagViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "기기 검색",
        leftButton: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bluetooth_searching, size: 80, color: Colors.blue),
            SizedBox(height: 20),

            /// 검색 시작 버튼 (리스트 위로 이동)
            ElevatedButton(
              onPressed: tagViewModel.isScanning
                  ? null
                  : () => tagViewModel.startScan(
                        Duration(seconds: 5),
                      ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    tagViewModel.isScanning ? Colors.grey : Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(tagViewModel.isScanning ? "검색 중..." : "재검색"),
            ),
            SizedBox(height: 25),

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
                    final existingTag =
                        tagViewModel.tags.cast<Tag?>().firstWhere(
                              (tag) =>
                                  tag?.remoteId == device.remoteId.toString(),
                              orElse: () => null,
                            );

                    return ListTile(
                      title: Text(
                        existingTag?.name ??
                            (device.platformName.isNotEmpty
                                ? device.platformName
                                : "Unknown Device"),
                      ),
                      subtitle: Text(device.remoteId.toString()),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          bool success = await tagViewModel.connectToDevice(
                              device.remoteId.toString(),
                              autoConnect: false);
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TagRegistrationScreen(
                                  deviceName:
                                      existingTag?.name ?? device.platformName,
                                  remoteId: device.remoteId.toString(),
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              existingTag != null ? Colors.orange : Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(existingTag != null ? "재설정" : "연결"),
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
