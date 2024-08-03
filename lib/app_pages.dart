import 'package:get/get.dart';

import 'presentation/screens/task/add_task_page.dart';
import 'presentation/screens/Home/homepage.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/add', page: () => AddTaskPage()),
  ];
}
