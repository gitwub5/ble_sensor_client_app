import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/viewmodel/tag_data_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class TagDataScreen extends StatelessWidget {
  final Tag tag;

  const TagDataScreen({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TagDataViewModel>(context, listen: false);

    // 데이터 불러오기
    viewModel.fetchTagData(tag.id);

    return Scaffold(
      appBar: CustomAppBar(
        title: "${tag.name}",
        leftButton: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<TagDataViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.tagDataList.isEmpty) {
            return Center(child: Text("등록된 데이터가 없습니다."));
          }

          final tagDataList = viewModel.tagDataList;

          // 온도 데이터 변환
          final temperatureSpots = tagDataList.map((tagData) {
            final timeInMilliseconds =
                tagData.time.millisecondsSinceEpoch.toDouble();
            return FlSpot(timeInMilliseconds, tagData.temperature);
          }).toList();

          // 습도 데이터 변환
          final humiditySpots = tagDataList.map((tagData) {
            final timeInMilliseconds =
                tagData.time.millisecondsSinceEpoch.toDouble();
            return FlSpot(timeInMilliseconds, tagData.humidity);
          }).toList();

          return Column(
            children: [
              Container(
                height: 300,
                padding: EdgeInsets.all(16),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 60 * 60 * 1000, // 1시간마다 표시
                          getTitlesWidget: (value, meta) {
                            final date = DateTime.fromMillisecondsSinceEpoch(
                                value.toInt());
                            final hourMinute = DateFormat('HH:mm').format(date);
                            final day = DateFormat('MM/dd').format(date);

                            if (date.hour == 0 && date.minute == 0) {
                              // 날짜가 바뀌는 순간 표시
                              return Text(day, style: TextStyle(fontSize: 10));
                            } else {
                              // 기본 시간 표시
                              return Text(hourMinute,
                                  style: TextStyle(fontSize: 8));
                            }
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: temperatureSpots,
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.red,
                        dotData: FlDotData(show: false),
                      ),
                      LineChartBarData(
                        spots: humiditySpots,
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.blue,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tagDataList.length,
                  itemBuilder: (context, index) {
                    final tagData = tagDataList[index];
                    return ListTile(
                      title: Text(
                          "온도: ${tagData.temperature}°C, 습도: ${tagData.humidity}%"),
                      subtitle: Text("시간: ${tagData.time.toLocal()}"),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
