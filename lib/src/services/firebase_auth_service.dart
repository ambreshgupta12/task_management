import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  FirebaseAuthService._();

  static final FirebaseAuthService firebaseAuthService =
      FirebaseAuthService._();

  factory FirebaseAuthService() => firebaseAuthService;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  FutureOr<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      if (kDebugMode) {
        debugPrint('displayName:${userCredential.user?.displayName}');
        debugPrint('email:${userCredential.user?.email}');
        debugPrint('photoURL:${userCredential.user?.photoURL}');
        debugPrint('uid:${userCredential.user?.uid}');
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return null;
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      return user;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error occurred while getting current user: $e');
      }
      return null; // Handle the error, possibly log it, and return null
    }
  }

  Future<bool> isUserSignedIn() async {
    try {
      User? user = await getCurrentUser();
      return user != null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error occurred while checking user sign-in status: $e');
      }
      return false; // Handle the error, possibly log it, and return false
    }
  }
}
