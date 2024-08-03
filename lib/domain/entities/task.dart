class Task {
  final int? id;
  final String title;
  final int isCompleted;

  Task({
    this.id,
    required this.title,
    required this.isCompleted,
  });

  Task copyWith({
    int? id,
    String? title,
    int? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
