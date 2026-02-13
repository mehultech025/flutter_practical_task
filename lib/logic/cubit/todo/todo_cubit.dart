import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/data/models/todo_model.dart';
import 'package:flutter_practical_task/logic/cubit/internet/internet_cubit.dart';
import 'package:flutter_practical_task/services/background_service.dart';
import 'package:flutter_practical_task/services/notification_services.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';
import 'package:hive/hive.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final InternetCubit internetCubit;

  TodoCubit(this.internetCubit) : super(TodoInitial()) {
    loadTodos();
  }

  final Box<TodoModel> box = Hive.box<TodoModel>('todos');
  Timer? _timer;
  int remainingSeconds = 0;
  int _runningIndex = -1;

  void loadTodos() {
    if (!internetCubit.state) {
      emit(TodoError(noInternetKey));
    } else {
      try {
        emit(TodoLoading());
        final todos = box.values.toList();
        emit(TodoSuccess(todos, message: ''));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    }
  }

  void addTodo({
    required String title,
    required String description,
    required int minutes,
    required int seconds,
  }) async {
    try {
      emit(TodoLoading());

      box.add(
        TodoModel(
          title: title,
          description: description,
          minutes: minutes,
          seconds: seconds,
          status: "TODO",
          createdAt: DateTime.now(),
        ),
      );
      loadTodos();
      NotificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: "Task Added",
        body: "$title added successfully",
      );

    } catch (e) {
      emit(TodoError(defaultErrorMessageKey));
    }
  }

  void updateTodo({
    required int index,
    required String title,
    required String description,
    required int minutes,
    required int seconds,
  }) async {
    try {
      emit(TodoLoading());

      final updatedTodo = TodoModel(
        title: title,
        description: description,
        minutes: minutes,
        seconds: seconds,
        status: "TODO",
        createdAt: DateTime.now(),
      );

      await box.putAt(index, updatedTodo);

      final updatedList = box.values.toList();

      emit(TodoSuccess(updatedList, message: "Task updated successfully"));
      NotificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: "Task Updated",
        body: "$title updated successfully",
      );
    } catch (e) {
      emit(TodoError(defaultErrorMessageKey));
    }
  }

  void deleteTodo(int index) async {
    try {
      emit(TodoLoading());

      await box.deleteAt(index);

      final updatedList = box.values.toList();

      emit(TodoSuccess(updatedList, message: "Task deleted successfully"));
      NotificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: "Task Deleted",
        body: "Task deleted successfully",
      );
      // _checkAndStopService();
    } catch (e) {
      emit(TodoError(defaultErrorMessageKey));
    }
  }

  void searchTodo(String query) {
    try {
      if (query.isEmpty) {
        loadTodos();
      } else {
        final results = box.values
            .where(
              (todo) => todo.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

        emit(TodoSuccess(results, message: addTaskMsgKey));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void updateStatus({required int index, required String status}) async {
    try {
      emit(TodoLoading());

      final oldTodo = box.getAt(index);

      final updatedTodo = TodoModel(
        title: oldTodo!.title,
        description: oldTodo.description,
        minutes: oldTodo.minutes,
        seconds: oldTodo.seconds,
        status: status,
        createdAt: oldTodo.createdAt,
      );

      await box.putAt(index, updatedTodo);

      final updatedList = box.values.toList();

      emit(TodoSuccess(updatedList, message: "Status updated"));
    } catch (e) {
      emit(TodoError("Failed to update status"));
    }
  }

  void startTimer(int index) {
    final todo = box.getAt(index);

    _runningIndex = index;
    remainingSeconds = todo!.minutes * 60 + todo.seconds;

    _timer?.cancel();

    updateStatus(index: index, status: inProgressStatusKey);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;

        final updatedTodo = TodoModel(
          title: todo.title,
          description: todo.description,
          minutes: remainingSeconds ~/ 60,
          seconds: remainingSeconds % 60,
          status: inProgressStatusKey,
          createdAt: todo.createdAt,
        );

        box.putAt(index, updatedTodo);

        emit(TodoSuccess(box.values.toList(), message: ""));
        // _checkAndStartService();
      } else {
        timer.cancel();
        updateStatus(index: index, status: doneStatusKey);
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();

    if (_runningIndex != -1) {
      updateStatus(index: _runningIndex, status: pausedStatusKey);
    }
    // _checkAndStartService();
  }

  void stopTimer(int index) {
    _timer?.cancel();

    final todo = box.getAt(index);

    final resetTodo = TodoModel(
      title: todo!.title,
      description: todo.description,
      minutes: todo.minutes,
      seconds: todo.seconds,
      status: doneStatusKey,
      createdAt: todo.createdAt,
    );

    box.putAt(index, resetTodo);

    emit(TodoSuccess(box.values.toList(), message: ""));
    // _checkAndStopService();
  }

  // Future<void> _checkAndStartService() async {
  //
  //   final hasActiveTask = box.values.any((todo) =>
  //   todo.status == inProgressStatusKey ||
  //       todo.status == pauseStatusKey);
  //
  //   if (hasActiveTask) {
  //     print("🟢 Active task found → Starting service");
  //     BackgroundService.start();
  //   } else {
  //     print("⚪ No active task → Not starting service");
  //   }
  // }

  // void _checkAndStopService() {
  //
  //   final hasActiveTask = box.values.any((todo) =>
  //   todo.status == inProgressStatusKey ||
  //       todo.status == pauseStatusKey);
  //
  //   if (!hasActiveTask) {
  //     print("🔴 No active task → Stopping service");
  //     BackgroundService.stop();
  //   }
  // }



  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
