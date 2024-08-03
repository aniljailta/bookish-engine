import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/config/app_string_constants.dart';
import '../../../di/injection.dart';
import '../../../domain/entities/task.dart';
import '../../controllers/task_controller.dart';

class HomePage extends StatelessWidget {
  final TaskController taskController = locator<TaskController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton.icon(
            onPressed: () => Get.toNamed('/add'),
            icon: const Icon(Icons.add),
            label: const Text(AppStrings.addTaskButtonLabel),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: TabBar(
              tabAlignment: TabAlignment.fill,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withOpacity(0.2),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list),
                      SizedBox(width: 8),
                      Text(AppStrings.showAllFilter),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle),
                      SizedBox(width: 8),
                      Text(AppStrings.showCompletedFilter),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pending),
                      SizedBox(width: 8),
                      Text(AppStrings.showPendingFilter),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  _buildTaskList(context, TaskFilter.all),
                  _buildTaskList(context, TaskFilter.completed),
                  _buildTaskList(context, TaskFilter.pending),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, TaskFilter filter) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
      child: Obx(() {
        final filteredTasks = taskController.getFilteredTasks(filter);

        if (filteredTasks.isEmpty) {
          return _buildEmptyState(context, filter);
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final Task task = filteredTasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted != 0
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit,
                            color: Theme.of(context).colorScheme.primary),
                        onPressed: () => _showEditDialog(context, task),
                      ),
                      Checkbox(
                        value: task.isCompleted == 0 ? false : true,
                        onChanged: (bool? value) {
                          taskController.toggleTaskCompletion(task.id!);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: Theme.of(context).colorScheme.secondary),
                        onPressed: () {
                          taskController.deleteTask(task.id!);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

  void _showEditDialog(BuildContext context, Task task) {
    final TextEditingController textController =
        TextEditingController(text: task.title);

    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(AppStrings.editTask),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: AppStrings.editTaskInputPlaceholder,
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            child: const Text(AppStrings.cancelButtonLabel),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            child: const Text(AppStrings.saveButtonLabel),
            onPressed: () {
              if (textController.text.isNotEmpty) {
                taskController.editTaskTitle(
                  textController.text,
                  task.id!,
                );
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, TaskFilter filter) {
    String message;
    switch (filter) {
      case TaskFilter.all:
        message = AppStrings.emptyAllTasksMessage;
        break;
      case TaskFilter.completed:
        message = AppStrings.emptyCompletedMessage;
        break;
      case TaskFilter.pending:
        message = AppStrings.emptyPendingMessage;
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 100,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.taskListPlaceholder,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }
}
