import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/app_routes.dart';
import 'package:task_manager/src/controller/auth/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = CurvedAnimation(parent: animationController, curve: Curves.linear);
    animationController.forward();

    animationController.addListener(() {
      if (animationController.isCompleted) {
        _checkAuthenticationAndNavigate();
      }
    });
  }

  void _checkAuthenticationAndNavigate() {
    AuthController authController = Get.find<AuthController>();
    if (authController.isUserSignedIn()) {
      debugPrint("if isUserSignedIn:${authController.isUserSignedIn()}");
      Get.offNamed(AppRoutes.taskListScreen); // User is signed in, navigate to task list screen
    } else {
      debugPrint("else isUserSignedIn");
      Get.offNamed(AppRoutes.signInScreen); // User is not signed in, navigate to login screen
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.whiteFCD,
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child: const FlutterLogo(size: 280),
        ),
      ),
    );
  }
}
