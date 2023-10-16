import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager/src/constants/app_routes.dart';
import 'package:task_manager/src/constants/string_constants.dart';
import 'package:task_manager/src/services/firebase_auth_service.dart';
import 'package:task_manager/src/utils/snackbar_util.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Rx<User?> user = Rx<User?>(null); // Rx variable for the user state

  @override
  void onInit() {
    super.onInit();
    debugPrint("onInit calling");
    checkUser(); // Check user authentication status when the controller is initialized
  }

  Future<void> signInWithGoogle() async {
    try {
      String? errorMessage = await _authService.signInWithGoogle();
      if (errorMessage == null) {
        await checkUser();
        if (isUserSignedIn()) {
          Get.offAllNamed(
              AppRoutes.taskListScreen); // Navigate if user is signed in
        } else {
          // Handle the case where the user is not signed in
          SnackBarUtils.showErrorSnackBar(message: KString.failedToSignInError);
        }
      } else {
        // Handle error messages returned from the authentication service
        SnackBarUtils.showErrorSnackBar(message: errorMessage);
      }
    } catch (e) {
      // Handle generic errors and show toast message
      SnackBarUtils.showErrorSnackBar(message: KString.pleaseTryAgainError);
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOutFromGoogle();
    } catch (e) {
      // Handle errors during sign-out and show toast message
      SnackBarUtils.showErrorSnackBar(message: KString.failedToSignInError);
    }
  }

  Future<void> checkUser() async {
    try {
      User? currentUser = await _authService.getCurrentUser();
      user.value = currentUser; // Update user state
    } catch (e) {
      // Handle errors during user check and show toast message
      SnackBarUtils.showErrorSnackBar(
          message: KString.failedToFetchUserDataError);
    }
  }

  // Method to check if the user is signed in

  bool isUserSignedIn() {
    return user.value != null;
  }
}
