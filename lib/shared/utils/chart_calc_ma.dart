import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// 🔹 이동 평균 계산 함수
List<FlSpot> calculateMovingAverage(List<FlSpot> spots, {int windowSize = 5}) {
  final List<FlSpot> smoothed = [];
  for (int i = 0; i < spots.length; i++) {
    int start = (i - windowSize ~/ 2).clamp(0, spots.length - 1);
    int end = (i + windowSize ~/ 2).clamp(0, spots.length - 1);

    final window = spots.sublist(start, end + 1);
    final averageY =
        window.map((e) => e.y).reduce((a, b) => a + b) / window.length;
    smoothed.add(FlSpot(spots[i].x, averageY));
  }
  return smoothed;
}

/// 🔹 이상치 구간 판단 함수 (X축 기준 범위 반환)
List<VerticalRangeAnnotation> findOutlierRanges(
  List<FlSpot> original,
  List<FlSpot> average,
  double threshold,
) {
  final List<VerticalRangeAnnotation> segments = [];

  bool isOutlier = false;
  double? startX;

  for (int i = 0; i < original.length; i++) {
    final diff = (original[i].y - average[i].y).abs();
    if (diff > threshold) {
      if (!isOutlier) {
        isOutlier = true;
        startX = original[i].x;
      }
    } else {
      if (isOutlier && startX != null) {
        segments.add(
          VerticalRangeAnnotation(
            x1: startX,
            x2: original[i].x,
            color: Colors.yellowAccent.withOpacity(0.3),
          ),
        );
        isOutlier = false;
        startX = null;
      }
    }
  }

  // 마지막까지 이상치인 경우
  if (isOutlier && startX != null) {
    segments.add(
      VerticalRangeAnnotation(
        x1: startX,
        x2: original.last.x,
        color: Colors.yellowAccent.withOpacity(0.3),
      ),
    );
  }

  return segments;
}
