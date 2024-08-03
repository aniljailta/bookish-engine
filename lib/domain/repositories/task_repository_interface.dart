import '../entities/task.dart';

abstract class ITaskRepository {
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
  Future<List<Task>> getTasks();
  Future<void> editTaskTitle(Task task);
}
