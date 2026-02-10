import 'package:flutter/material.dart';
import '../../models/user.dart';

class StudentDashboard extends StatelessWidget {
  final AppUser user;

  StudentDashboard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Dashboard')),
      body: Center(child: Text('Welcome, ${user.name} (Student)')),
    );
  }
}
