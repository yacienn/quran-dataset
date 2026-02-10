import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/firestore_service.dart';
import '../../models/exam.dart';

class ExamResultsScreen extends StatelessWidget {
  final AppUser user;
  final FirestoreService firestoreService = FirestoreService();

  ExamResultsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exam Results')),
      body: StreamBuilder<List<Exam>>(
        stream: firestoreService.getExamsForStudent(user.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final exams = snapshot.data!;
          return ListView.builder(
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              final grade = exam.results[user.id] ?? '-';
              return ListTile(
                title: Text(exam.title),
                subtitle: Text('Grade: $grade'),
              );
            },
          );
        },
      ),
    );
  }
}
