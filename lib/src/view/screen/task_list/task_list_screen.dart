import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/app_routes.dart';
import 'package:task_manager/src/constants/string_constants.dart';
import 'package:task_manager/src/controller/auth/auth_controller.dart';
import 'package:task_manager/src/controller/task/task_controller.dart';
import 'package:task_manager/src/res/dimensions/dimensions.dart';
import 'package:task_manager/src/res/theme/text_styles.dart';
import 'package:task_manager/src/utils/snackbar_util.dart';

class TaskListScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final taskController = Get.find<TaskController>();

  TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(KString.taskList),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(authController.user.value?.displayName ?? '',
                  style: osTextStyle14Regular),
              accountEmail: Text(authController.user.value?.email ?? '',
                  style: osTextStyle14Regular),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage(authController.user.value?.photoURL ?? ''),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              contentPadding:
                  const EdgeInsets.only(left: Dimens.px8, right: Dimens.px8),
              leading: const Icon(Icons.exit_to_app, color: KColors.deepPurple),
              title: const Text(KString.signOut, style: osTextStyle16Medium),
              onTap: () async {
                await authController.signOut().then((_) {
                  Get.offAllNamed(AppRoutes.signInScreen);
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (taskController.isLoading.value) {
              return const CircularProgressIndicator();
            } else {
              if (taskController.tasks.isEmpty) {
                return const Text(KString.noTasksFound,
                    style: osTextStyle16Medium);
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: KColors.black12,
                    height: 0.5,
                    thickness: 0.8,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px8),
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    var task = taskController.tasks[index];
                    return Dismissible(
                      key: Key(task.taskId), // Unique key for each task
                      background: Container(color: KColors.errorColor),
                      onDismissed: (direction) async {
                        await taskController.deleteTask(task.taskId);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.px16, vertical: Dimens.px4),
                        child: ListTile(
                          onTap: () => Get.toNamed(AppRoutes.addTaskScreen,
                              arguments: task)!
                              .then((value) {
                            if (value != null) {
                              Future.delayed(
                                  const Duration(milliseconds: 500), () {
                                SnackBarUtils.showSuccessSnackBar(
                                    message: KString.taskUpdatedSuccessfully);
                              });
                            }
                          }),
                          title: Text(task.description),
                          trailing: Checkbox(
                            checkColor: KColors.whiteColor,
                            activeColor: KColors.deepPurple,
                            tristate: true,
                            value: task.isComplete,
                            onChanged: (value) {
                              task.isComplete = value!;
                              taskController.updateTask(
                                  task.taskId, task.description,
                                  isTaskStatus: task.isComplete);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KColors.deepPurple,
        tooltip: KString.addTask,
        child: const Icon(
          Icons.add,
          color: KColors.whiteColor,
        ),
        onPressed: () => Get.toNamed(AppRoutes.addTaskScreen, arguments: null)!
            .then((value) {
          if (value != null) {
            Future.delayed(const Duration(milliseconds: 500), () {
              SnackBarUtils.showSuccessSnackBar(
                  message: KString.taskAddedSuccessfully);
            });
          }
        }),
      ),
    );
  }
}
