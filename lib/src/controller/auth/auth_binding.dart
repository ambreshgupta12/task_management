import 'package:get/get.dart';
import 'package:task_manager/src/controller/auth/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(),permanent: true);
  }
}