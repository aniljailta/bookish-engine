import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository_interface.dart';
import '../models/task_model.dart';
import '../services/db_service.dart';

class TaskRepository implements ITaskRepository {
  final DBService _dbService;

  TaskRepository(this._dbService);

  @override
  Future<void> addTask(Task task) async {
    await _dbService.addTask(TaskModel(id: task.id, title: task.title).toMap());
  }

  @override
  Future<void> deleteTask(int id) async {
    await _dbService.deleteTask(id);
  }

  @override
  Future<List<Task>> getTasks() async {
    final taskMaps = await _dbService.getTasks();
    return taskMaps.map((taskMap) => TaskModel.fromMap(taskMap)).toList();
  }
}
