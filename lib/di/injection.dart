import 'package:get_it/get_it.dart';
import '../data/repositories/task_repository.dart';
import '../data/services/db_service.dart';
import '../domain/usecases/add_task.dart';
import '../domain/usecases/delete_task.dart';
import '../domain/usecases/edit_task_title.dart';
import '../domain/usecases/get_tasks.dart';
import '../domain/usecases/update_task.dart';
import '../presentation/controllers/task_controller.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton<DBService>(() => DBService());

  // Repositories
  locator.registerLazySingleton<TaskRepository>(
      () => TaskRepository(locator<DBService>()));

  // Use cases
  locator
      .registerLazySingleton<AddTask>(() => AddTask(locator<TaskRepository>()));
  locator.registerLazySingleton<DeleteTask>(
      () => DeleteTask(locator<TaskRepository>()));
  locator.registerLazySingleton<GetTasks>(
      () => GetTasks(locator<TaskRepository>()));
  locator.registerLazySingleton<UpdateTask>(
      () => UpdateTask(locator<TaskRepository>()));
  locator.registerLazySingleton<EditTaskTitle>(
      () => EditTaskTitle(locator<TaskRepository>()));

  // Controllers
  locator.registerLazySingleton<TaskController>(() => TaskController(
        addTaskUseCase: locator<AddTask>(),
        deleteTaskUseCase: locator<DeleteTask>(),
        getTasksUseCase: locator<GetTasks>(),
        updateTaskUseCase: locator<UpdateTask>(),
        editTaskTitleUseCase: locator<EditTaskTitle>(),
      ));
}
