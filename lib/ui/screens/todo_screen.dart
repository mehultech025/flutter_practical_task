import 'package:flutter/material.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/router/app_router.dart';
import 'package:flutter_practical_task/ui/widgets/add_todo_bottomsheet.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/ui/widgets/todo_card.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> allTasks = [
    {"title": "Design UI", "description": "Create beautiful layout"},
    {"title": "Timer Feature", "description": "Implement timer logic"},
    {"title": "Testing", "description": "Test all functionality"},
  ];

  List<Map<String, String>> filteredTasks = [];

  @override
  void initState() {
    super.initState();
    filteredTasks = allTasks;
  }

  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const AddTodoBottomSheet(),
    );
  }

  void _searchTask(String query) {
    final results = allTasks.where((task) {
      return task["title"]!
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredTasks = results;
    });
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
              borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: welcomeKey,
                  fontSize: 14,
                  color: whiteFFFFFFColor.withOpacity(0.9),
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
                  onChanged: _searchTask,
                  decoration: InputDecoration(
                    hintText: searchKey,
                    prefixIcon:
                    const Icon(Icons.search, color: textSecondaryColor),
                    filled: true,
                    fillColor: whiteFFFFFFColor,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 0),
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
            child: ListView.builder(
              padding:
              const EdgeInsets.fromLTRB(20, 25, 20, 20),
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return TodoCard(
                  title: task["title"]!,
                  description: task["description"]!,
                  status: "TODO",
                  timer: "00:00:00",
                  onEdit: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => const AddTodoBottomSheet(isEdit: true),
                    );
                  },
                  onDelete: () {
                    setState(() {
                      allTasks.remove(task);
                      filteredTasks.remove(task);
                    });
                  },
                  onTap: () {
                    AppRouter.navigatorKey.currentState?.pushNamed(
                      AppRouter.details,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}