import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/config/app_string_constants.dart';
import '../../../di/injection.dart';
import '../../controllers/task_controller.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();
  final TaskController taskCtrl = locator<TaskController>();

  AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(AppStrings.addTaskButtonLabel),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: AppStrings.addTaskInputPlaceholder,
                hintText: AppStrings.taskInputPlaceholder,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = taskController.text.trim();
                if (title.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(AppStrings.taskInputValidationMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  taskCtrl.addTask(title);
                  Get.back();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(AppStrings.saveButtonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
