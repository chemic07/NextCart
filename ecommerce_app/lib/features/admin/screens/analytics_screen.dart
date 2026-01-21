import 'package:ecommerce_app/features/admin/widgets/category_pie_chart.dart';
import 'package:ecommerce_app/features/admin/widgets/daily_line_chart.dart';
import 'package:ecommerce_app/models/analytics.dart';
import 'package:flutter/material.dart';
import '../services/admin_services.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  Analytics? analytics;
  bool isLoading = true;

  TimeFilter selectedFilter = TimeFilter.day;

  @override
  void initState() {
    super.initState();
    fetchAnalytics();
  }

  void fetchAnalytics() async {
    final data = await adminServices.getAnalytics(context: context);
    setState(() {
      analytics = data;
      isLoading = false;
    });
  }

  List<Map<String, dynamic>> get filteredData {
    switch (selectedFilter) {
      case TimeFilter.day:
        return analytics!.byDay;
      case TimeFilter.week:
        return analytics!.byWeek;
      case TimeFilter.month:
        return analytics!.byMonth;
      case TimeFilter.year:
        return analytics!.byYear;
    }
  }

  String Function(Map<String, dynamic>) get labelBuilder {
    switch (selectedFilter) {
      case TimeFilter.day:
        return dayLabel;
      case TimeFilter.week:
        return weekLabel;
      case TimeFilter.month:
        return monthLabel;
      case TimeFilter.year:
        return yearLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return const Center(child: CircularProgressIndicator());
    if (analytics == null) {
      return const Center(child: Text("Failed to load analytics"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOTAL
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.attach_money, size: 32),
                const SizedBox(width: 10),
                Text(
                  "Total Earnings: ₹${analytics!.totalEarnings}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // PIE CHART
          const Text(
            "Earnings by Category",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: CategoryPieChart(data: analytics!.byCategory),
          ),

          const SizedBox(height: 30),

          // FILTER + BAR CHART
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Earnings Over Time",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<TimeFilter>(
                value: selectedFilter,
                items: const [
                  DropdownMenuItem(
                    value: TimeFilter.day,
                    child: Text("Day"),
                  ),
                  DropdownMenuItem(
                    value: TimeFilter.week,
                    child: Text("Week"),
                  ),
                  DropdownMenuItem(
                    value: TimeFilter.month,
                    child: Text("Month"),
                  ),
                  DropdownMenuItem(
                    value: TimeFilter.year,
                    child: Text("Year"),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedFilter = val);
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 240,
            child: EarningsBarChart(
              data: filteredData,
              labelBuilder: labelBuilder,
            ),
          ),
        ],
      ),
    );
  }
}

String dayLabel(Map<String, dynamic> item) {
  final date = item['_id'].toString(); // 2026-01-21
  return date.substring(5); // 01-21
}

String weekLabel(Map<String, dynamic> item) {
  return "W${item['_id']['week']}";
}

String monthLabel(Map<String, dynamic> item) {
  return "${item['_id']['month']}/${item['_id']['year']}";
}

String yearLabel(Map<String, dynamic> item) {
  return item['_id']['year'].toString();
}

enum TimeFilter { day, week, month, year }
