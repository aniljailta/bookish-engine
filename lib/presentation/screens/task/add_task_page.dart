import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = taskController.text;
                if (title.isNotEmpty) {
                  taskCtrl.addTask(title);
                  Get.back();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
