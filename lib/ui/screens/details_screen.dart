import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/data/models/todo_model.dart';
import 'package:flutter_practical_task/logic/cubit/todo/todo_cubit.dart';
import 'package:flutter_practical_task/ui/widgets/add_todo_bottomsheet.dart';
import 'package:flutter_practical_task/ui/widgets/control_button.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/utils/constants/constants.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';

class DetailsScreen extends StatefulWidget {
  final TodoModel todo;
  final int index;

  const DetailsScreen({super.key, required this.todo, required this.index});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  late int _remainingSeconds;

  String formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    _remainingSeconds = widget.todo.minutes * 60 + widget.todo.seconds;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        backgroundColor: scaffoldF5F5F7Color,
        appBar: AppBar(
          backgroundColor: whiteFFFFFFColor,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            text: taskDetailsKey,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textPrimaryColor,
          ),
          iconTheme: const IconThemeData(color: textPrimaryColor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: textPrimaryColor),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            final currentTodo = (state is TodoSuccess)
                ? state.todos[widget.index]
                : widget.todo;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: whiteFFFFFFColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: shadow000000Color,
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: currentTodo.title,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimaryColor,
                                ),

                                const SizedBox(height: 8),

                                CustomText(
                                  text: currentTodo.description,
                                  fontSize: 14,
                                  color: textSecondaryColor,
                                ),

                                const SizedBox(height: 16),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(
                                      currentTodo.status,
                                    ).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CustomText(
                                    text: currentTodo.status,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: getStatusColor(currentTodo.status),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          Center(
                            child: Column(
                              children: [
                                CustomText(
                                  text: formatTime(
                                    currentTodo.minutes * 60 +
                                        currentTodo.seconds,
                                  ),
                                  fontSize: 42,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimaryColor,
                                ),
                                const SizedBox(height: 6),
                                CustomText(
                                  text: runningTimerKey,
                                  fontSize: 14,
                                  color: textSecondaryColor,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ControlButton(
                                icon: currentTodo.status == inProgressStatusKey
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                label: currentTodo.status == inProgressStatusKey
                                    ? pauseStatusKey
                                    : playStatusKey,
                                color: blue007AFFColor,
                                onTap: () {
                                  if (currentTodo.status ==
                                      inProgressStatusKey) {
                                    context.read<TodoCubit>().pauseTimer();
                                  } else {
                                    context.read<TodoCubit>().startTimer(
                                      widget.index,
                                    );
                                  }
                                },
                              ),

                              ControlButton(
                                icon: Icons.stop,
                                label: stopStatusKey,
                                color: redFF3B30Color,
                                onTap: () {
                                  context.read<TodoCubit>().stopTimer(
                                    widget.index,
                                  );
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple8D15FFColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        context.read<TodoCubit>().pauseTimer();

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => BlocProvider.value(
                            value: context.read<TodoCubit>(),
                            child: AddTodoBottomSheet(
                              isEdit: true,
                              index: widget.index,
                              todo: currentTodo,
                            ),
                          ),
                        );

                      },
                      icon: const Icon(Icons.edit, color: whiteFFFFFFColor),
                      label: CustomText(
                        text: editTaskKey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: whiteFFFFFFColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
