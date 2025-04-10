import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/view/day_screen.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/view/month_screen.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/view/week_screen.dart';
import 'package:bluetooth_app/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/viewmodel/tag_data_viewmodel.dart';

class TagDataScreen extends StatefulWidget {
  final Tag tag;

  const TagDataScreen({Key? key, required this.tag}) : super(key: key);

  @override
  State<TagDataScreen> createState() => _TagDataScreenState();
}

class _TagDataScreenState extends State<TagDataScreen> {
  String _selectedView = 'day';

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<TagDataViewModel>(context, listen: false);
    viewModel.fetchTagData(widget.tag.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.tag.name,
        leftButton: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<TagDataViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // 👉 선택 탭 영역
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Text('Month'),
                      selected: _selectedView == 'month',
                      onSelected: (_) =>
                          setState(() => _selectedView = 'month'),
                    ),
                    SizedBox(width: 8),
                    ChoiceChip(
                      label: Text('Week'),
                      selected: _selectedView == 'week',
                      onSelected: (_) => setState(() => _selectedView = 'week'),
                    ),
                    SizedBox(width: 8),
                    ChoiceChip(
                      label: Text('Day'),
                      selected: _selectedView == 'day',
                      onSelected: (_) => setState(() => _selectedView = 'day'),
                    ),
                  ],
                ),
              ),
              // 👉 차트 영역
              Expanded(
                child: _buildChartBySelectedView(viewModel.tagDataList),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChartBySelectedView(List<TagDataData> tagDataList) {
    switch (_selectedView) {
      case 'day':
        return DayScreen(tagDataList: tagDataList); // ✅ 여기에서 렌더링
      case 'week':
        return WeekScreen(tagDataList: tagDataList);
      case 'month':
        return MonthScreen(tagDataList: tagDataList);
      default:
        return Center(child: Text("측정된 데이터가 없습니다."));
    }
  }
}
