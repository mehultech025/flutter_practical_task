part of 'todo_cubit.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoSuccess extends TodoState {
  final List<TodoModel> todos;
  final String message;
  TodoSuccess(this.todos, {required this.message});
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}