import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/shared/utils/chart_calc_ma.dart';

class DayChart extends StatefulWidget {
  final List<TagDataData> tagDataList;
  final DateTime selectedDate;

  const DayChart({
    Key? key,
    required this.tagDataList,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<DayChart> createState() => _DayChartState();
}

class _DayChartState extends State<DayChart> {
  bool _showTemperature = true;
  bool _showHumidity = false;
  double _minX = 0.0;
  double _maxX = 24.0;
  double _viewWindowSize = 24.0;
  final List<double> _zoomLevels = [24.0, 12.0, 6.0, 3.0, 1.0, 0.5];
  int _currentZoomIndex = 0;
  final ValueNotifier<double> _scrollX = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _scrollX.value = _minX;
  }

  void _zoomIn() {
    setState(() {
      if (_currentZoomIndex < _zoomLevels.length - 1) {
        _currentZoomIndex++;
        _viewWindowSize = _zoomLevels[_currentZoomIndex];
        _maxX = _minX + _viewWindowSize;

        // 범위 초과 방지
        if (_maxX > 24.0) {
          _maxX = 24.0;
          _minX = _maxX - _viewWindowSize;
        }
      }
    });
  }

  void _zoomOut() {
    setState(() {
      if (_currentZoomIndex > 0) {
        _currentZoomIndex--;
        _viewWindowSize = _zoomLevels[_currentZoomIndex];
        _maxX = _minX + _viewWindowSize;

        if (_maxX > 24.0) {
          _maxX = 24.0;
          _minX = _maxX - _viewWindowSize;
        }
        if (_minX < 0.0) {
          _minX = 0.0;
          _maxX = _viewWindowSize;
        }
      }
    });
  }

  void _updateScroll(double value) {
    setState(() {
      _minX = value;
      _maxX = value + _viewWindowSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = widget.tagDataList.where((tagData) {
      return tagData.time.year == widget.selectedDate.year &&
          tagData.time.month == widget.selectedDate.month &&
          tagData.time.day == widget.selectedDate.day;
    }).toList();

    if (filteredData.isEmpty) {
      return Center(child: Text("해당 날짜에 데이터가 없습니다."));
    }

    filteredData.sort((a, b) => a.time.compareTo(b.time));

    final temperatureSpots = filteredData.map((tagData) {
      final time = tagData.time.hour + tagData.time.minute / 60;
      return FlSpot(time, tagData.temperature);
    }).toList();

    final humiditySpots = filteredData.map((tagData) {
      final time = tagData.time.hour + tagData.time.minute / 60;
      return FlSpot(time, tagData.humidity);
    }).toList();

    double? minY, maxY;
    if (_showTemperature) {
      final temps = temperatureSpots.map((e) => e.y);
      final minVal = temps.reduce((a, b) => a < b ? a : b);
      final maxVal = temps.reduce((a, b) => a > b ? a : b);
      minY = minVal - 3;
      maxY = maxVal + 3;
    } else if (_showHumidity) {
      final hums = humiditySpots.map((e) => e.y);
      final minVal = hums.reduce((a, b) => a < b ? a : b);
      final maxVal = hums.reduce((a, b) => a > b ? a : b);
      minY = minVal - 3;
      maxY = maxVal + 3;
    }

    final visibleTemperatureSpots = temperatureSpots
        .where((spot) => spot.x >= _minX && spot.x <= _maxX)
        .toList();
    final visibleHumiditySpots = humiditySpots
        .where((spot) => spot.x >= _minX && spot.x <= _maxX)
        .toList();

    final average = calculateMovingAverage(
        _showTemperature ? temperatureSpots : humiditySpots);
    final outlierRegions = findOutlierRanges(
      _showTemperature ? temperatureSpots : humiditySpots,
      average,
      _showTemperature ? 1.0 : 5.0,
    );

    return Column(
      children: [
        SizedBox(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: LineChart(
              LineChartData(
                minX: _minX,
                maxX: _maxX,
                minY: minY,
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  verticalInterval: 3,
                  horizontalInterval: 1,
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 25,
                      getTitlesWidget: (value, meta) {
                        final isEdge = value == minY || value == maxY;
                        if (isEdge) return const SizedBox.shrink();

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_showTemperature)
                              Text('${value.toInt()}°',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.red)),
                            if (_showHumidity)
                              Text('${value.toInt()}%',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blue)),
                          ],
                        );
                      },
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 3,
                      getTitlesWidget: (value, meta) {
                        final hour = value.floor();
                        final minute = ((value - hour) * 60).round();
                        final formatted = DateFormat('HH:mm')
                            .format(DateTime(0, 1, 1, hour, minute));
                        return Text(formatted, style: TextStyle(fontSize: 10));
                      },
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  if (_showTemperature)
                    LineChartBarData(
                      spots: visibleTemperatureSpots,
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.red,
                      dotData: FlDotData(show: false),
                    ),
                  if (_showHumidity)
                    LineChartBarData(
                      spots: visibleHumiditySpots,
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.blue,
                      dotData: FlDotData(show: false),
                    ),
                ],
                rangeAnnotations:
                    RangeAnnotations(verticalRangeAnnotations: outlierRegions),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blue, // 이동한 부분
              inactiveTrackColor: Colors.grey[300], // 이동하지 않은 부분
              thumbColor: Colors.blue, // 슬라이더 버튼 색
              overlayColor: Colors.blue.withAlpha(32),
              trackHeight: 4,
            ),
            child: Slider(
              value: _minX.clamp(0.0, 24.0 - _viewWindowSize),
              min: 0,
              max: 24.0 - _viewWindowSize,
              divisions: (24.0 - _viewWindowSize) > 0
                  ? ((24.0 - _viewWindowSize) * 2).round()
                  : null,
              label: '${_minX.toStringAsFixed(1)}h',
              onChanged: (val) => _updateScroll(val),
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
            const SizedBox(width: 8),
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
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.zoom_in),
              onPressed: _zoomIn,
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: Icon(Icons.zoom_out),
              onPressed: _zoomOut,
            ),
          ],
        ),
      ],
    );
  }
}
