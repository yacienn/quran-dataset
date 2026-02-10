import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String teacherId;
  final String? studentId;
  final String classId;
  final String content;
  final DateTime createdAt;

  Report({
    required this.id,
    required this.teacherId,
    this.studentId,
    required this.classId,
    required this.content,
    required this.createdAt,
  });

  factory Report.fromMap(String id, Map<String, dynamic> data) {
    final timestamp = data['createdAt'];

    // Safe conversion
    DateTime createdAt;
    if (timestamp is Timestamp) {
      createdAt = timestamp.toDate();
    } else if (timestamp is DateTime) {
      createdAt = timestamp;
    } else {
      createdAt = DateTime.now(); // fallback if missing
    }

    return Report(
      id: id,
      teacherId: data['teacherId'] ?? '',
      studentId: data['studentId'],
      classId: data['classId'] ?? '',
      content: data['content'] ?? '',
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teacherId': teacherId,
      'studentId': studentId,
      'classId': classId,
      'content': content,
      'createdAt': createdAt, // Firestore can store DateTime directly
    };
  }
}
