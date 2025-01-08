import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Exception: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      log('Unknown error: $e');
      return null;
    }
  }
}
