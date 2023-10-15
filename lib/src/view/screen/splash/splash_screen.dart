
import 'package:flutter/material.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/route_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  void navigationPage() {
    Navigator.of(context)
        .pushReplacementNamed(RoutePath.taskListScreen);
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);

    animationController.addListener(() => setState(() {
      if (animationController.isCompleted) {
        navigationPage();
      }
    }));
    animationController.forward();
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: animation.value * 280,
                height: animation.value * 280,
                child: const FlutterLogo(),
              )
            ],
          ),
        ],
      ),
    );
  }
}