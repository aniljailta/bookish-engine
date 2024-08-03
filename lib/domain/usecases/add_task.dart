import '../entities/task.dart';
import '../repositories/task_repository_interface.dart';

class AddTask {
  final ITaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) async {
    await repository.addTask(task);
  }
}
