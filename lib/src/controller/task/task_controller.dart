import 'package:get/get.dart';
import 'package:task_manager/src/model/task_model.dart';
import 'package:task_manager/src/services/task_service.dart';

class TaskController extends GetxController {
  final TaskService _taskService = TaskService();
  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;
  var error = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      var taskList = await _taskService.getAllTaskList();
      tasks.assignAll(taskList);
    } catch (e) {
      error.value = 'Error fetching tasks: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTask(String description) async {
    try {
      isLoading.value = true;
      await _taskService.createTask(description);
      fetchTasks();
    } catch (e) {
      error.value = 'Error adding task: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(String taskId, String description,{bool? isTaskStatus}) async {
    try {
      isLoading.value = true;
      await _taskService.updateTask(taskId, description,isTaskStatus: isTaskStatus);
      fetchTasks();
    } catch (e) {
      error.value = 'Error updating task: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      isLoading.value = true;
      await _taskService.deleteTask(taskId);
      fetchTasks();
    } catch (e) {
      error.value = 'Error deleting task: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
