import 'package:get/get.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';

class TaskController extends GetxController {
  final AddTask addTaskUseCase;
  final DeleteTask deleteTaskUseCase;
  final GetTasks getTasksUseCase;

  TaskController({
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
    required this.getTasksUseCase,
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
    await addTaskUseCase(Task(title: title));
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await deleteTaskUseCase(id);
    loadTasks();
  }
}
