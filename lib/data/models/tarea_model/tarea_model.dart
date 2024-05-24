import 'dart:convert';

class TareaModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TareaModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TareaModel.fromRawJson(String str) =>
      TareaModel.fromJson(json.decode(str));

  factory TareaModel.fromJson(Map<String, dynamic> json) => TareaModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );
}
