import '../entities/task.dart';
import '../repositories/task_repository_interface.dart';

class EditTaskTitle {
  final ITaskRepository repository;

  EditTaskTitle(this.repository);

  Future<void> call(Task task) async {
    await repository.editTaskTitle(task);
  }
}
