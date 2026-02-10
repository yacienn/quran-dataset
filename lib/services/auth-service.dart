import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login with email
  Future<AppUser?> login(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      String uid = cred.user!.uid;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) return null;

      return AppUser.fromMap(uid, userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Signup (teacher/student) - optional
  Future<AppUser?> signup(
      String email, String password, String name, String role) async {
    try {
      UserCredential cred =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String uid = cred.user!.uid;

      AppUser user = AppUser(id: uid, name: name, email: email, role: role);
      await _firestore.collection('users').doc(uid).set(user.toMap());
      return user;
    } catch (e) {
      print('Signup error: $e');
      return null;
    }
  }
}
