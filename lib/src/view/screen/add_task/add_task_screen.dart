import 'package:flutter/material.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/string_constants.dart';
import 'package:task_manager/src/res/dimensions/dimensions.dart';
import 'package:task_manager/src/res/theme/text_styles.dart';
import 'package:task_manager/src/utils/minixs/validation_mixin.dart';
import 'package:task_manager/src/view/widgets/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                      borderRadius: BorderRadius.circular(Dimens.px28)),
                  minimumSize: const Size.fromHeight(Dimens.px44), // NEW
                ),
                onPressed: () => {if (_formKey.currentState!.validate()) {}},
                child: const Text(
                  KString.saveTask,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
