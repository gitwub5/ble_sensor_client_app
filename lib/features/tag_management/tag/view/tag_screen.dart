import 'package:bluetooth_app/features/tag_management/tag/view/bluetooth_scan_screen.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/view/tag_data_screen.dart';
import 'package:bluetooth_app/features/tag_management/tag/view/widget/tag_widget.dart';
import 'package:bluetooth_app/shared/widgets/custom_appbar.dart';
import 'package:bluetooth_app/shared/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tag_viewmodel.dart';

class TagScreen extends StatefulWidget {
  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final tagViewModel = Provider.of<TagViewModel>(context, listen: false);
      await tagViewModel.loadTags();
    });
  }

  Future<void> _refreshTags() async {
    await Provider.of<TagViewModel>(context, listen: false).loadTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tag 관리",
        rightButton: IconButton(
            onPressed: () => _navigateToBluetoothScanScreen(context),
            icon: Icon(Icons.add)),
      ),
      body: Consumer<TagViewModel>(
        builder: (context, tagViewModel, child) {
          if (tagViewModel.homeViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (tagViewModel.tags.isEmpty) {
            return Center(
              child: Text(
                "등록된 태그가 없습니다.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            color: Colors.blue,
            displacement: 40.0,
            strokeWidth: 3.0,
            onRefresh: _refreshTags,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 10),
              itemCount: tagViewModel.tags.length,
              itemBuilder: (context, index) {
                final tag = tagViewModel.tags[index];
                return ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width),
                  child: TagWidget(
                    tag: tag,
                    tagViewModel: tagViewModel,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TagDataScreen(tag: tag),
                      ),
                    ),
                    onDelete: () => _showDeleteConfirmationDialog(
                      context,
                      tagViewModel,
                      tag.id,
                    ),
                    onEditName: () => print("이름 수정 클릭됨!"),
                  ),
                );
              },
            ),
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

  void _showDeleteConfirmationDialog(
      BuildContext context, TagViewModel tagViewModel, int tagId) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "태그 삭제 확인",
          content: "기존 데이터가 전부 삭제됩니다.\n정말로 삭제하시겠습니까?",
          leftButtonText: "아니요",
          rightButtonText: "예",
          onConfirm: () {
            tagViewModel.removeTag(tagId);
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
