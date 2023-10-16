import 'package:get/get.dart';
import 'package:task_manager/src/constants/app_routes.dart';
import 'package:task_manager/src/controller/auth/auth_binding.dart';
import 'package:task_manager/src/controller/task/auth_binding.dart';
import 'package:task_manager/src/view/screen/add_task/add_task_screen.dart';
import 'package:task_manager/src/view/screen/sign_in/sign_in_screen.dart';
import 'package:task_manager/src/view/screen/splash/splash_screen.dart';
import 'package:task_manager/src/view/screen/task_list/task_list_screen.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashScreen>(
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
      preventDuplicates: true,
      binding: AuthBinding(),
    ),
    GetPage<SignInScreen>(
      name: AppRoutes.signInScreen,
      page: () => const SignInScreen(),
      transition: Transition.fadeIn,
      preventDuplicates: true,
      binding: AuthBinding(),
    ),
    GetPage<AddTaskScreen>(
      name: AppRoutes.addTaskScreen,
      page: () => const AddTaskScreen(),
      transition: Transition.fadeIn,
      preventDuplicates: true,
        binding: TaskBinding()
    ),
    GetPage<TaskListScreen>(
      name: AppRoutes.taskListScreen,
      page: () => TaskListScreen(),
      transition: Transition.fadeIn,
      preventDuplicates: true,
      binding: TaskBinding()
    ),
  ];
}
