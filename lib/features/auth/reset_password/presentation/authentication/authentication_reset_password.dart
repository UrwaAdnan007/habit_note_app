import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceResetPassword {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // New password reset function
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      log('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Exception: ${e.code} - ${e.message}');
    } catch (e) {
      log('Unknown error: $e');
    }
  }
}
