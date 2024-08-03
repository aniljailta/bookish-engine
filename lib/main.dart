import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/app_pages.dart';
import 'bindings/bindings.dart';
import 'config/apptheme.dart';
import 'di/injection.dart' as get_it;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  get_it.setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Do',
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      getPages: AppPages.routes,
    );
  }
}
