import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/exam.dart';
import '../models/report.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get exams for a student
  Stream<List<Exam>> getExamsForStudent(String userId) {
    return _firestore.collection('exams').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Exam.fromMap(doc.id, doc.data())).toList());
  }

  // Get reports for a student
  Stream<List<Report>> getReportsForStudent(String studentId, String classId) {
    return _firestore
        .collection('reports')
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Report.fromMap(doc.id, doc.data())).toList());
  }

  // Send report
  Future<void> sendReport(Report report) async {
    await _firestore.collection('reports').add(report.toMap());
  }

  // Get students for a class
  Future<List<AppUser>> getStudents(String classId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('classId', isEqualTo: classId)
        .where('role', isEqualTo: 'student')
        .get();
    return snapshot.docs
        .map((doc) => AppUser.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }
}
