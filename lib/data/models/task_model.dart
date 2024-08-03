import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({super.id, required super.title});

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
      };
}
