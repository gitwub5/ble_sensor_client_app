import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryChart extends StatelessWidget {
  final double maxTemp;
  final double minTemp;
  final double maxHumidity;
  final double minHumidity;
  final double averageTemp;
  final double averageHumidity;

  const SummaryChart({
    super.key,
    required this.maxTemp,
    required this.minTemp,
    required this.maxHumidity,
    required this.minHumidity,
    required this.averageTemp,
    required this.averageHumidity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("🌡️ 온도 요약",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(height: 180, child: _buildTempChart()),
          const SizedBox(height: 16),
          const Text("💧 습도 요약", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(height: 180, child: _buildHumidityChart()),
        ],
      ),
    );
  }

  Widget _buildTempChart() {
    final maxY = [maxTemp, minTemp].reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: maxY + 5,
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
              toY: maxTemp,
              color: Colors.red,
              width: 15,
              borderRadius: BorderRadius.zero,
            )
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
              toY: minTemp,
              color: Colors.red.shade200,
              width: 15,
              borderRadius: BorderRadius.zero,
            )
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
              toY: averageTemp,
              color: Colors.orange,
              width: 15,
              borderRadius: BorderRadius.zero,
            )
          ]),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final labels = ['최고', '최저', '평균'];
                return SideTitleWidget(
                  meta: meta,
                  child: Text(labels[value.toInt()],
                      style: TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final maxY = [maxTemp, minTemp, averageTemp]
                        .reduce((a, b) => a > b ? a : b) +
                    5;
                if (value == maxY) return const SizedBox.shrink();
                return SideTitleWidget(
                  meta: meta,
                  child:
                      Text('${value.toInt()}°', style: TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: 5,
        ),
        barTouchData: BarTouchData(enabled: true),
      ),
    );
  }

  Widget _buildHumidityChart() {
    final maxY = [maxHumidity, minHumidity].reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: maxY + 5,
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
              toY: maxHumidity,
              color: Colors.blue,
              width: 15,
              borderRadius: BorderRadius.zero,
            )
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
              toY: minHumidity,
              color: Colors.blue.shade200,
              width: 15,
              borderRadius: BorderRadius.zero,
            )
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
              toY: averageHumidity,
              color: Colors.cyan,
              width: 15,
              borderRadius: BorderRadius.zero,
            )
          ]),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final labels = ['최고', '최저', '평균'];
                return SideTitleWidget(
                  meta: meta,
                  child: Text(labels[value.toInt()],
                      style: TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 10,
              getTitlesWidget: (value, meta) {
                final maxY = [maxHumidity, minHumidity, averageHumidity]
                        .reduce((a, b) => a > b ? a : b) +
                    5;
                if (value == maxY) return const SizedBox.shrink();
                return SideTitleWidget(
                  meta: meta,
                  child:
                      Text('${value.toInt()}%', style: TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
        ),
        barTouchData: BarTouchData(enabled: true),
      ),
    );
  }
}
