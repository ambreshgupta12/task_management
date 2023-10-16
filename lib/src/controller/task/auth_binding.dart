import 'package:get/get.dart';
import 'package:task_manager/src/controller/task/task_controller.dart';

class TaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
  }
}