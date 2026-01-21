import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EarningsBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String Function(Map<String, dynamic>) labelBuilder;

  const EarningsBarChart({
    super.key,
    required this.data,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const Center(child: Text("No data"));

    final barGroups = <BarChartGroupData>[];

    for (int i = 0; i < data.length; i++) {
      final earnings = (data[i]['earnings'] as num).toDouble();

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: earnings,
              width: 18,
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue,
            ),
          ],
        ),
      );
    }

    return BarChart(
      BarChartData(
        minY: 0,
        barGroups: barGroups,
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= data.length) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    labelBuilder(data[index]),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
