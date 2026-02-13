import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/logic/cubit/todo/todo_cubit.dart';
import 'package:flutter_practical_task/router/app_router.dart';
import 'package:flutter_practical_task/ui/dialogue_box/custom_logout_dialog.dart';
import 'package:flutter_practical_task/ui/widgets/add_todo_bottomsheet.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/ui/widgets/no_task_widget.dart';
import 'package:flutter_practical_task/ui/widgets/todo_card.dart';
import 'package:flutter_practical_task/utils/constants/constants.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();


  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomLogoutDialog(),
    );
  }
  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<TodoCubit>(),
        child: const AddTodoBottomSheet(),
      ),
    );
  }

  void _showDeleteDialog(BuildContext parentContext, int index) {
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(deleteTaskKey),
          content: const Text(deleteTaskMsgKey),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(cancelKey),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                parentContext.read<TodoCubit>().deleteTodo(index);
              },
              child: const Text(deleteKey),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,

      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: purple8D15FFColor,
        onPressed: openBottomSheet,
        child: const Icon(Icons.add, color: whiteFFFFFFColor),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [purple8D15FFColor, purpleB388FFColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: welcomeKey,
                      fontSize: 14,
                      color: whiteFFFFFFColor.withOpacity(0.9),
                    ),
                    IconButton(
                      onPressed: () {
                        _showLogoutDialog();
                      },
                      icon: const Icon(Icons.logout, color: whiteFFFFFFColor),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                CustomText(
                  text: myTasksKey,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: whiteFFFFFFColor,
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (value) {
                    context.read<TodoCubit>().searchTodo(value);
                  },
                  decoration: InputDecoration(
                    hintText: searchKey,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: textSecondaryColor,
                    ),
                    filled: true,
                    fillColor: whiteFFFFFFColor,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TodoError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            context.read<TodoCubit>().loadTodos();
                          },
                          child: CustomText(text: retryKey, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
                if (state is TodoSuccess) {
                  if (state.todos.isEmpty) {
                    return const NoTaskWidget(
                      title: noTaskKey,
                      subtitle: noTaskMsgKey,
                      icon: Icons.task_alt,
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return TodoCard(
                        title: todo.title,
                        description: todo.description,
                        status: todo.status,
                        timer: formatTime(todo.minutes, todo.seconds),
                        onEdit: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => BlocProvider.value(
                              value: context.read<TodoCubit>(),
                              child: AddTodoBottomSheet(
                                isEdit: true,
                                index: index,
                                todo: todo,
                              ),
                            ),
                          );
                        },
                        onDelete: () {
                          _showDeleteDialog(context, index);
                        },
                        onTap: () async {
                          final result = await AppRouter
                              .navigatorKey
                              .currentState
                              ?.pushNamed(
                                AppRouter.details,
                                arguments: {"todo": todo, "index": index},
                              );
                          if (result == true) {
                            context.read<TodoCubit>().loadTodos();
                          }
                        },
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
