import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../di/injection.dart';
import '../../controllers/task_controller.dart';

class HomePage extends StatelessWidget {
  final TaskController taskController = locator<TaskController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (taskController.taskList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.task_alt,
                        size: 100,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'No tasks yet',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Your tasks will appear here',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: taskController.taskList.length,
                  itemBuilder: (context, index) {
                    final task = taskController.taskList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(task.title),
                        trailing: IconButton(
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).colorScheme.secondary),
                          onPressed: () {
                            taskController.deleteTask(task.id!);
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 50,
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed('/add'),
              icon: const Icon(Icons.add),
              label: const Text('Add New Task'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
