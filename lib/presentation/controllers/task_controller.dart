import 'package:get/get.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/edit_task_title.dart'; // New import

enum TaskFilter { all, completed, pending }

class TaskController extends GetxController {
  final AddTask addTaskUseCase;
  final DeleteTask deleteTaskUseCase;
  final GetTasks getTasksUseCase;
  final UpdateTask updateTaskUseCase;
  final EditTaskTitle editTaskTitleUseCase;

  TaskController({
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
    required this.getTasksUseCase,
    required this.updateTaskUseCase,
    required this.editTaskTitleUseCase,
  });

  var taskList = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final tasks = await getTasksUseCase();
    taskList.assignAll(tasks);
  }

  Future<void> addTask(String title) async {
    await addTaskUseCase(Task(title: title, isCompleted: 0));
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await deleteTaskUseCase(id);
    loadTasks();
  }

  Future<void> toggleTaskCompletion(int id) async {
    final taskIndex = taskList.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final task = taskList[taskIndex];
      final newIsCompleted = task.isCompleted == 0 ? 1 : 0;
      final updatedTask = task.copyWith(isCompleted: newIsCompleted);
      await updateTaskUseCase(updatedTask);
      loadTasks();
    }
  }

  // New method for editing task title
  Future<void> editTaskTitle(
    String newTitle,
    int id,
  ) async {
    final taskIndex = taskList.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final task = taskList[taskIndex];
      final updatedTask = task.copyWith(title: newTitle);
      await editTaskTitleUseCase(updatedTask);
      loadTasks();
    }
  }

  List<Task> getFilteredTasks(TaskFilter filter) {
    switch (filter) {
      case TaskFilter.all:
        return taskList;
      case TaskFilter.completed:
        return taskList.where((task) => task.isCompleted == 1).toList();
      case TaskFilter.pending:
        return taskList.where((task) => task.isCompleted == 0).toList();
    }
  }
}
