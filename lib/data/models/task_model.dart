import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    super.id,
    required super.title,
    required super.isCompleted,
  });

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        title: json['title'],
        isCompleted: json['isCompleted'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };

  @override
  TaskModel copyWith({
    int? id,
    String? title,
    int? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
