import 'package:flutter/material.dart';
import 'package:task_manager/src/constants/route_path.dart';
import 'package:task_manager/src/constants/string_constants.dart';
import 'package:task_manager/src/res/theme/app_theme.dart';
import 'package:task_manager/src/routes/routes.dart';
import 'package:task_manager/src/view/screen/sign_in/sign_in_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      //initialRoute: RoutePath.splashScreen,
      title: KString.appName,
      theme: AppTheme.lightTheme,
      home: const SignInScreen(),
    );
  }
}
