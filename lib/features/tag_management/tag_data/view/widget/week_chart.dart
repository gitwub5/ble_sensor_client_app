import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/shared/utils/chart_calc_ma.dart';

class WeekChart extends StatefulWidget {
  final List<TagDataData> tagDataList;
  final DateTime startOfWeek;

  const WeekChart({
    Key? key,
    required this.tagDataList,
    required this.startOfWeek,
  }) : super(key: key);

  @override
  State<WeekChart> createState() => _WeekChartState();
}

class _WeekChartState extends State<WeekChart> {
  bool _showTemperature = true;
  bool _showHumidity = false;
  final ValueNotifier<double> _scrollX = ValueNotifier(0.0);
  final double _viewWindow = 2.0;

  late double _fixedMinTempY;
  late double _fixedMaxTempY;
  late double _fixedMinHumidityY;
  late double _fixedMaxHumidityY;

  @override
  void initState() {
    super.initState();
    _scrollX.value = 0.0;

    final allWeekData = widget.tagDataList.where((tagData) {
      final date = tagData.time;
      return !date.isBefore(widget.startOfWeek) &&
          !date.isAfter(widget.startOfWeek.add(Duration(days: 7)));
    }).toList();

    final tempList = allWeekData.map((e) => e.temperature).toList();
    final humList = allWeekData.map((e) => e.humidity).toList();

    _fixedMinTempY =
        tempList.isEmpty ? 0 : tempList.reduce((a, b) => a < b ? a : b) - 2;
    _fixedMaxTempY =
        tempList.isEmpty ? 10 : tempList.reduce((a, b) => a > b ? a : b) + 2;

    _fixedMinHumidityY =
        humList.isEmpty ? 30 : humList.reduce((a, b) => a < b ? a : b) - 5;
    _fixedMaxHumidityY =
        humList.isEmpty ? 80 : humList.reduce((a, b) => a > b ? a : b) + 5;
  }

  @override
  Widget build(BuildContext context) {
    final weekData = widget.tagDataList.where((tagData) {
      final date = tagData.time;
      return !date.isBefore(widget.startOfWeek) &&
          !date.isAfter(widget.startOfWeek.add(Duration(days: 7)));
    }).toList();

    if (weekData.isEmpty) {
      return const Center(child: Text("해당 주간에 데이터가 없습니다."));
    }

    final temperatureSpots = weekData.map((data) {
      final x = data.time.difference(widget.startOfWeek).inMinutes / 1440.0;
      return FlSpot(x, data.temperature);
    }).toList();

    final humiditySpots = weekData.map((data) {
      final x = data.time.difference(widget.startOfWeek).inMinutes / 1440.0;
      return FlSpot(x, data.humidity);
    }).toList();

    return Column(
      children: [
        SizedBox(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ValueListenableBuilder<double>(
              valueListenable: _scrollX,
              builder: (context, scrollX, _) {
                final minX = scrollX;
                final maxX = minX + _viewWindow;

                final visibleSpots =
                    (_showTemperature ? temperatureSpots : humiditySpots)
                        .where((e) => e.x >= minX && e.x <= maxX)
                        .toList();

                final minY =
                    _showTemperature ? _fixedMinTempY : _fixedMinHumidityY;
                final maxY =
                    _showTemperature ? _fixedMaxTempY : _fixedMaxHumidityY;

                final average = calculateMovingAverage(visibleSpots);
                final outlierRegions = findOutlierRanges(
                  visibleSpots,
                  average,
                  _showTemperature ? 1.0 : 5.0,
                );

                return LineChart(
                  LineChartData(
                    minX: minX,
                    maxX: maxX,
                    minY: minY,
                    maxY: maxY,
                    gridData: FlGridData(
                      show: true,
                      horizontalInterval: 1,
                      verticalInterval: 0.5,
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 0.5,
                          getTitlesWidget: (value, meta) {
                            final days = ['일', '월', '화', '수', '목', '금', '토'];
                            final dayIndex = value.floor();
                            final hour = (value % 1 == 0) ? '00:00' : '12:00';
                            if (dayIndex < 0 || dayIndex >= 7)
                              return const SizedBox.shrink();
                            return Text('${days[dayIndex]} $hour',
                                style: const TextStyle(fontSize: 10));
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            final isEdge = value == minY || value == maxY;
                            if (isEdge) return const SizedBox.shrink();
                            return Text(
                              _showTemperature
                                  ? '${value.toInt()}°'
                                  : '${value.toInt()}%',
                              style: TextStyle(
                                fontSize: 10,
                                color:
                                    _showTemperature ? Colors.red : Colors.blue,
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: visibleSpots.isEmpty
                        ? []
                        : [
                            LineChartBarData(
                              spots: visibleSpots,
                              isCurved: true,
                              barWidth: 3,
                              color:
                                  _showTemperature ? Colors.red : Colors.blue,
                              dotData: FlDotData(show: false),
                            )
                          ],
                    rangeAnnotations: RangeAnnotations(
                      verticalRangeAnnotations: outlierRegions,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: Colors.blue,
              overlayColor: Colors.blue.withAlpha(32),
              trackHeight: 4,
            ),
            child: Slider(
              min: 0,
              max: 7.0 - _viewWindow,
              value: _scrollX.value.clamp(0.0, 7.0 - _viewWindow),
              onChanged: (val) {
                setState(() {
                  _scrollX.value = val.clamp(0.0, 7.0 - _viewWindow);
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: _showTemperature,
              onChanged: (val) {
                setState(() {
                  _showTemperature = val ?? true;
                  _showHumidity = !_showTemperature;
                });
              },
            ),
            Icon(Icons.thermostat, color: Colors.red),
            const SizedBox(width: 16),
            Checkbox(
              value: _showHumidity,
              onChanged: (val) {
                setState(() {
                  _showHumidity = val ?? true;
                  _showTemperature = !_showHumidity;
                });
              },
            ),
            Icon(Icons.water_drop, color: Colors.blue),
          ],
        ),
      ],
    );
  }
}
