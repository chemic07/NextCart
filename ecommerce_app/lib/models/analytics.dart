class Analytics {
  final int totalEarnings;
  final List<Map<String, dynamic>> byCategory;
  final List<Map<String, dynamic>> byDay;
  final List<Map<String, dynamic>> byWeek;
  final List<Map<String, dynamic>> byMonth;
  final List<Map<String, dynamic>> byYear;

  Analytics({
    required this.totalEarnings,
    required this.byCategory,
    required this.byDay,
    required this.byWeek,
    required this.byMonth,
    required this.byYear,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) {
    return Analytics(
      totalEarnings: json['totalEarnings'],
      byCategory: List<Map<String, dynamic>>.from(
        json['earningsByCategory'].map(
          (item) => {
            'category': item['category'],
            'earnings': item['earnings'],
          },
        ),
      ),
      byDay: List<Map<String, dynamic>>.from(json['earningsByDay']),
      byWeek: List<Map<String, dynamic>>.from(json['earningsByWeek']),
      byMonth: List<Map<String, dynamic>>.from(
        json['earningsByMonth'],
      ),
      byYear: List<Map<String, dynamic>>.from(json['earningsByYear']),
    );
  }
}
