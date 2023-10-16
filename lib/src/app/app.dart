import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/src/constants/app_routes.dart';
import 'package:task_manager/src/constants/string_constants.dart';
import 'package:task_manager/src/res/theme/app_theme.dart';
import 'package:task_manager/src/routes/routes.dart';
import 'package:task_manager/src/utils/keyboard_util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        initialRoute: AppRoutes.splashScreen,
        defaultTransition: Transition.fadeIn,
        title: KString.appName,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
