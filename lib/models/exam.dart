class Exam {
  final String id;
  final String title;
  final DateTime date;
  final Map<String, int> results;

  Exam({required this.id, required this.title, required this.date, required this.results});

  factory Exam.fromMap(String id, Map<String, dynamic> data) {
    Map<String, int> res = {};
    if (data['results'] != null) {
      data['results'].forEach((key, value) => res[key] = value);
    }
    return Exam(
      id: id,
      title: data['title'] ?? '',
      date: (data['date'] as DateTime?) ?? DateTime.now(),
      results: res,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'results': results,
    };
  }
}
