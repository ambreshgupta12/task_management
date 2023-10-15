import 'package:flutter/material.dart';
import 'package:task_manager/src/constants/route_path.dart';
import 'package:task_manager/src/view/screen/add_task/add_task_screen.dart';
import 'package:task_manager/src/view/screen/sign_in/sign_in_screen.dart';
import 'package:task_manager/src/view/screen/splash/splash_screen.dart';
import 'package:task_manager/src/view/screen/task_list/task_list_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint(settings.name);
    switch (settings.name) {
      case RoutePath.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutePath.signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case RoutePath.taskListScreen:
        return MaterialPageRoute(builder: (_) => const TaskListScreen());
      case RoutePath.addTaskScreen:
        return MaterialPageRoute(builder: (_) => const AddTaskScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
