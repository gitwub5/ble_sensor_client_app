import 'package:bluetooth_app/features/tag_management/tag_data/view/widget/summary_chart.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/view/widget/week_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bluetooth_app/core/database/database.dart';

class WeekScreen extends StatefulWidget {
  final List<TagDataData> tagDataList;

  const WeekScreen({
    Key? key,
    required this.tagDataList,
  }) : super(key: key);

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  late DateTime _startOfWeek;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startOfWeek = now.subtract(Duration(days: now.weekday % 7)); // 일요일 시작
  }

  void _goToPreviousWeek() {
    setState(() {
      _startOfWeek = _startOfWeek.subtract(const Duration(days: 7));
    });
  }

  void _goToNextWeek() {
    setState(() {
      _startOfWeek = _startOfWeek.add(const Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _endOfWeek = _startOfWeek.add(const Duration(days: 6));

    final filteredData = widget.tagDataList.where((tagData) {
      final date = tagData.time;
      return date.isAfter(_startOfWeek.subtract(const Duration(seconds: 1))) &&
          date.isBefore(_endOfWeek.add(const Duration(days: 1)));
    }).toList();

    final maxTemp = filteredData.map((e) => e.temperature).fold<double>(
        double.negativeInfinity, (prev, curr) => curr > prev ? curr : prev);
    final minTemp = filteredData.map((e) => e.temperature).fold<double>(
        double.infinity, (prev, curr) => curr < prev ? curr : prev);

    final maxHumidity = filteredData.map((e) => e.humidity).fold<double>(
        double.negativeInfinity, (prev, curr) => curr > prev ? curr : prev);
    final minHumidity = filteredData.map((e) => e.humidity).fold<double>(
        double.infinity, (prev, curr) => curr < prev ? curr : prev);

    final averageTemp = double.parse(
      (filteredData
                  .map((e) => e.temperature)
                  .fold(0.0, (sum, val) => sum + val) /
              filteredData.length)
          .toStringAsFixed(2),
    );

    final averageHumidity = double.parse(
      (filteredData.map((e) => e.humidity).fold(0.0, (sum, val) => sum + val) /
              filteredData.length)
          .toStringAsFixed(2),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🔹 주간 이동 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _goToPreviousWeek,
                icon: Icon(Icons.chevron_left),
              ),
              Text(
                "${DateFormat('MM월 dd일').format(_startOfWeek)} ~ ${DateFormat('MM월 dd일').format(_endOfWeek)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _goToNextWeek,
                icon: Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 🔹 차트 영역 (WeekChart는 추후 구현)
          SizedBox(
            height: 460,
            child: WeekChart(
              tagDataList: filteredData,
              startOfWeek: _startOfWeek,
            ),
          ),
          const SizedBox(height: 8),
          // 🔹 요약 차트
          if (filteredData.isNotEmpty)
            SummaryChart(
              maxTemp: maxTemp,
              minTemp: minTemp,
              maxHumidity: maxHumidity,
              minHumidity: minHumidity,
              averageTemp: averageTemp,
              averageHumidity: averageHumidity,
            )
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text("해당 주간 데이터가 없습니다."),
              ),
            ),
        ],
      ),
    );
  }
}
