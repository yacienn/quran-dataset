import 'package:flutter/material.dart';
import '../services/auth-service.dart';
import 'student/student_dashboard.dart';
import 'teacher/teacher_dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  bool loading = false;

  void login() async {
    setState(() => loading = true);
    final user = await _auth.login(
        _emailController.text.trim(), _passwordController.text.trim());
    setState(() => loading = false);

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed')));
      return;
    }

    // Navigate based on role
    if (user.role == 'student') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => StudentDashboard(user: user)));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => TeacherDashboard(user: user)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            loading ? CircularProgressIndicator() :
            ElevatedButton(onPressed: login, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
