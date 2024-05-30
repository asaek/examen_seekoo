class TareaEntity {
  final int userId;
  final int? id;
  final String title;
  final bool completed;

  TareaEntity({
    required this.userId,
    this.id,
    required this.title,
    required this.completed,
  });

  TareaEntity copyWith({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) {
    return TareaEntity(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
