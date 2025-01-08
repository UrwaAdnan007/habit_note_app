import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceLogout {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      log('User signed out successfully');
    } catch (e) {
      log('Sign out error: $e');
      throw Exception('Failed to sign out. Please try again.');
    }
  }
}
