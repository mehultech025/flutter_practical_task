import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String status;

  @HiveField(3)
  int minutes;

  @HiveField(4)
  int seconds;

  // 👇 NEW FIELD
  @HiveField(5)
  DateTime createdAt;

  TodoModel({
    required this.title,
    required this.description,
    this.status = "TODO",
    this.minutes = 0,
    this.seconds = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}