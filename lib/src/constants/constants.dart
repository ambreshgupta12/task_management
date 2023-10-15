import 'package:flutter/services.dart';
import 'package:task_manager/src/constants/color_constants.dart';

class Constants {
  //colors


  //text
  static const title = "Google Sign In";
  static const textIntro = "Growing your \n business is ";
  static const textIntroDesc1 = "easier \n ";
  static const textIntroDesc2 = "then you think!";
  static const textSmallSignUp = "Sign up takes only 2 minutes!";
  static const textSignIn = "Sign In";
  static const textStart = "Get Started";
  static const textSignInTitle = "Welcome back!";
  static const textSmallSignIn = "You've been missed";
  static const textSignInGoogle = "Sign In With Google";
  static const textAcc = "Don't have an account? ";
  static const textSignUp = "Sign Up here";
  static const textHome = "Home";

  //navigate
  static const signInNavigate = '/sign-in';
  static const homeNavigate = '/home';

  static const statusBarColor = SystemUiOverlayStyle(
      statusBarColor: KColors.kPrimaryColor,
      statusBarIconBrightness: Brightness.dark);
}