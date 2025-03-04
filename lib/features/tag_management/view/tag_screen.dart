import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tag_viewmodel.dart';
import './bluetooth_scan_screen.dart'; // 새 블루투스 탐색 페이지 import

class TagScreen extends StatefulWidget {
  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  @override
  void initState() {
    super.initState();
    // 📌 태그 데이터 로드
    Future.microtask(
        () => Provider.of<TagViewModel>(context, listen: false).loadTags());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tag 관리")),
      body: Consumer<TagViewModel>(
        builder: (context, tagViewModel, child) {
          return tagViewModel.isLoading
              ? Center(child: CircularProgressIndicator()) // 로딩 인디케이터 추가
              : Column(
                  children: [
                    Expanded(
                      child: tagViewModel.tags.isEmpty
                          ? Center(
                              child: Text("등록된 태그가 없습니다.",
                                  style: TextStyle(color: Colors.grey)),
                            )
                          : ListView.builder(
                              itemCount: tagViewModel.tags.length,
                              itemBuilder: (context, index) {
                                final tag = tagViewModel.tags[index];
                                return Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: tag.isSelected,
                                      onChanged: (value) {
                                        tagViewModel.toggleSelection(index);
                                      },
                                    ),
                                    title:
                                        Text("${tag.name} (${tag.remoteId})"),
                                    subtitle: Text(
                                      "업데이트: ${tag.updatedAt} | 냉장고: ${tag.fridgeName}",
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
                          /// ✅ 버튼 크기 맞추기 위해 `Expanded` 사용
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  _navigateToBluetoothScanScreen(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text("기기 등록",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 16), // 버튼 간격 추가
                          Expanded(
                            child: ElevatedButton(
                              onPressed:
                                  tagViewModel.tags.any((tag) => tag.isSelected)
                                      ? () => tagViewModel.removeSelectedTags()
                                      : null, // 선택된 태그가 없으면 버튼 비활성화
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                disabledBackgroundColor:
                                    Colors.grey, // 비활성화 시 색상 변경
                              ),
                              child: Text("해제",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
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
