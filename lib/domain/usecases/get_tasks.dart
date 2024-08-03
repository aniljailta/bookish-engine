import '../entities/task.dart';
import '../repositories/task_repository_interface.dart';

class GetTasks {
  final ITaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}
