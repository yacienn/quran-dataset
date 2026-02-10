import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/firestore_service.dart';
import '../../models/report.dart';

class TeacherReportsScreen extends StatelessWidget {
  final AppUser user;
  final FirestoreService firestoreService = FirestoreService();

  TeacherReportsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teacher Reports')),
      body: StreamBuilder<List<Report>>(
        stream: firestoreService.getReportsForStudent(user.id, user.classId!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final reports = snapshot.data!;
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return ListTile(
                title: Text(report.content),
                subtitle: Text('From teacher: ${report.teacherId}'),
              );
            },
          );
        },
      ),
    );
  }
}
