import 'package:flutter/material.dart';
import '../../models/user.dart';

class TeacherDashboard extends StatelessWidget {
  final AppUser user;

  TeacherDashboard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teacher Dashboard')),
      body: Center(child: Text('Welcome, ${user.name} (Teacher)')),
    );
  }
}
