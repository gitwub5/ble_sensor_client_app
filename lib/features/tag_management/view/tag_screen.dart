import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tag_viewmodel.dart';
import './bluetooth_scan_screen.dart'; // 새 블루투스 탐색 페이지 import

class TagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tagViewModel = Provider.of<TagViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Tag 관리")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tagViewModel.tags.length,
              itemBuilder: (context, index) {
                final tag = tagViewModel.tags[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Checkbox(
                      value: tag.isSelected,
                      onChanged: (value) {
                        tagViewModel.toggleSelection(index);
                      },
                    ),
                    title: Text("${tag.deviceName} (${tag.tagId})"),
                    subtitle: Text(
                      "업데이트: ${tag.lastUpdated} | 냉장고: ${tag.fridgeName}",
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      _navigateToBluetoothScanScreen(context), // 블루투스 탐색 페이지 이동
                  child: Text("등록"),
                ),
                ElevatedButton(
                  onPressed: () {
                    tagViewModel.removeSelectedTags();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("해제", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 📌 블루투스 탐색 페이지로 이동
  void _navigateToBluetoothScanScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BluetoothScanScreen()),
    );
  }
}
