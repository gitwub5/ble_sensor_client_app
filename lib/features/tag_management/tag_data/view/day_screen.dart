import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/view/widget/day_chart.dart';

class DayScreen extends StatefulWidget {
  final List<TagDataData> tagDataList;

  const DayScreen({
    Key? key,
    required this.tagDataList,
  }) : super(key: key);

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  void _goToPreviousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _goToNextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = widget.tagDataList.where((tagData) {
      final date = tagData.time;
      return date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🔹 날짜 이동 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _goToPreviousDay,
                icon: Icon(Icons.chevron_left),
              ),
              Text(
                DateFormat('yyyy년 MM월 dd일').format(selectedDate),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _goToNextDay,
                icon: Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 🔹 차트 영역
          SizedBox(
            height: 460,
            child: DayChart(
              tagDataList: filteredData,
              selectedDate: selectedDate,
            ),
          ),
          const SizedBox(height: 8),
          // 🔹 리스트 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "측정 데이터",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          if (filteredData.isEmpty)
            Center(
                child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text("데이터 없음"),
            ))
          else
            ...filteredData.map((tagData) => ListTile(
                  title: Text(
                      "온도: ${tagData.temperature}°C, 습도: ${tagData.humidity}%"),
                  subtitle: Text("시간: ${DateFormat.Hm().format(tagData.time)}"),
                )),
        ],
      ),
    );
  }
}
