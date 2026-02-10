import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/report.dart';
import '../../services/firestore_service.dart';

class SendReportScreen extends StatefulWidget {
  final AppUser teacher;
  final List<AppUser> students;

  SendReportScreen({required this.teacher, required this.students});

  @override
  _SendReportScreenState createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  final FirestoreService firestoreService = FirestoreService();
  AppUser? selectedStudent;
  final _contentController = TextEditingController();

  void send() async {
    if (_contentController.text.isEmpty) return;
    Report report = Report(
      id: '',
      teacherId: widget.teacher.id,
      studentId: selectedStudent?.id,
      classId: widget.teacher.classId ?? '',
      content: _contentController.text,
      createdAt: DateTime.now(),
    );
    await firestoreService.sendReport(report);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Report sent')));
    _contentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Report')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<AppUser>(
              hint: Text('Select student (or leave empty for whole class)'),
              value: selectedStudent,
              isExpanded: true,
              items: widget.students.map((s) {
                return DropdownMenuItem(value: s, child: Text(s.name));
              }).toList(),
              onChanged: (val) => setState(() => selectedStudent = val),
            ),
            TextField(controller: _contentController, decoration: InputDecoration(labelText: 'Report Content')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: send, child: Text('Send'))
          ],
        ),
      ),
    );
  }
}
