import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class PricePoint {
  late final double x;
  late final double y;
  PricePoint({required this.x, required this.y});
}

List<PricePoint> get pricePoints {
  final data = <double>[10, 8, 6, 4, 2, 5, 5];
  return data
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}

class CustomLineChart extends StatelessWidget {
  final List<PricePoint> points;
  final Function(double) onPointClicked;

  const CustomLineChart({
    Key? key,
    required this.points,
    required this.onPointClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final tapPosition = renderBox.globalToLocal(details.globalPosition);
          final tapX = tapPosition.dx / renderBox.size.width;

          // Find the nearest point to the tap
          double? nearestX;
          double minDistance = double.infinity;
          for (final point in points) {
            final distance = (point.x - tapX).abs();
            if (distance < minDistance) {
              minDistance = distance;
              nearestX = point.x;
            }
          }

          // If the distance to the nearest point is within a threshold, trigger the callback
          if (nearestX != null && minDistance < 0.05) {
            // Adjust threshold as needed
            onPointClicked(nearestX);
          }
        },
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
                isCurved: false,
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
