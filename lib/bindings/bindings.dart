import 'package:get/get.dart';
import '../di/injection.dart';
import '../presentation/controllers/task_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(locator<TaskController>());
  }
}
