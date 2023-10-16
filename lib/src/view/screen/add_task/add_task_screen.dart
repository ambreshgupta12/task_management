import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/string_constants.dart';
import 'package:task_manager/src/controller/task/task_controller.dart';
import 'package:task_manager/src/model/task_model.dart';
import 'package:task_manager/src/res/dimensions/dimensions.dart';
import 'package:task_manager/src/res/theme/text_styles.dart';
import 'package:task_manager/src/utils/snackbar_util.dart';
import 'package:task_manager/src/utils/validation_mixin.dart';
import 'package:task_manager/src/view/widgets/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _taskController;
  final _formKey = GlobalKey<FormState>();
  late String buttonText; // Variable to store the button text
  TaskModel? taskModel; // Variable to store the TaskModel instance

  @override
  void initState() {
    super.initState();
    // Retrieve the TaskModel instance from arguments if available
    var arguments = Get.arguments;
    if (arguments != null && arguments is TaskModel) {
      taskModel = arguments;
      _taskController =
          TextEditingController(text: taskModel?.description ?? '');
      buttonText = taskModel?.taskId.isNotEmpty == true
          ? KString.updateTask
          : KString.saveTask;
    } else {
      // Handle the case where arguments is null or not a TaskModel
      _taskController = TextEditingController();
      buttonText = KString.saveTask;
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(KString.addTask),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.px16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomTextField(
                maxLines: 3,
                minLines: 3,
                controller: _taskController,
                hintText: KString.enterTaskDescription,
                hintStyle: osTextStyle14Regular,
                style: osTextStyle14Medium.copyWith(color: KColors.primaryDark),
                validator: ValidationMixin.descriptionValidation,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: Dimens.px20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.px28),
                  ),
                  minimumSize: const Size.fromHeight(Dimens.px44),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    TaskController taskController = Get.find<TaskController>();
                    if (taskModel == null) {
                      await taskController
                          .createTask(_taskController.text.trim());
                      Get.back(result: 'Added');
                    } else {
                      await taskController.updateTask(
                          taskModel!.taskId, _taskController.text.trim());
                      Get.back(result: 'Updated');
                    }
                  }
                },
                child: Text(buttonText,
                    style:
                        osTextStyle16Medium), // Set the button text dynamically
              ),
            ],
          ),
        ),
      ),
    );
  }
}
