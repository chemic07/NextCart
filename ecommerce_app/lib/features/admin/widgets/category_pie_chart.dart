import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const Map<String, Color> categoryColors = {
  "Mobiles": Colors.blue,
  "Essentials": Colors.green,
  "Appliances": Colors.orange,
  "Books": Colors.purple,
  "Fashion": Colors.pink,
};

class CategoryPieChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CategoryPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("No data"));
    }

    final total = data.fold<double>(
      0,
      (sum, item) => sum + (item['earnings'] as num).toDouble(),
    );

    return PieChart(
      PieChartData(
        sections: data.map((item) {
          final value = (item['earnings'] as num).toDouble();
          final percent = total == 0
              ? "0"
              : (value / total * 100).toStringAsFixed(1);

          final category = item['category'] as String;

          return PieChartSectionData(
            value: value,
            title: "$category\n$percent%",
            radius: 80,
            color: categoryColors[category] ?? Colors.grey,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
        sectionsSpace: 2,
        centerSpaceRadius: 30,
      ),
    );
  }
}
