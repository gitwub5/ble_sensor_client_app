import 'package:bluetooth_app/features/tag_management/tag_data/view/widget/month_chart.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/view/widget/summary_chart.dart';
// import 'package:bluetooth_app/features/tag_management/tag_data/view/widget/month_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bluetooth_app/core/database/database.dart';

class MonthScreen extends StatefulWidget {
  final List<TagDataData> tagDataList;

  const MonthScreen({
    Key? key,
    required this.tagDataList,
  }) : super(key: key);

  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final startOfMonth = _currentMonth;
    final endOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1)
        .subtract(const Duration(seconds: 1));

    final filteredData = widget.tagDataList.where((tagData) {
      final date = tagData.time;
      return date.isAfter(startOfMonth.subtract(const Duration(seconds: 1))) &&
          date.isBefore(endOfMonth.add(const Duration(seconds: 1)));
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
          // 🔹 월 이동 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _goToPreviousMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                DateFormat('yyyy년 MM월').format(_currentMonth),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _goToNextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 🔹 차트 영역 (MonthChart는 추후 구현)
          SizedBox(
            height: 460,
            child: MonthChart(
              tagDataList: filteredData,
              startOfMonth: startOfMonth,
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
                child: Text("해당 월의 데이터가 없습니다."),
              ),
            ),
        ],
      ),
    );
  }
}
