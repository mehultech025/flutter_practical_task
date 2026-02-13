import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/core/app_colors.dart';
import 'package:flutter_practical_task/core/app_easy_loading.dart';
import 'package:flutter_practical_task/data/models/todo_model.dart';
import 'package:flutter_practical_task/logic/cubit/todo/todo_cubit.dart';
import 'package:flutter_practical_task/router/app_router.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';
import 'custom_text_field.dart';

class AddTodoBottomSheet extends StatefulWidget {
  final bool isEdit;
  final int? index;
  final TodoModel? todo;

  const AddTodoBottomSheet({
    super.key,
    this.isEdit = false,
    this.index,
    this.todo,
  });

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _minutesController = TextEditingController();

  final TextEditingController _secondsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description;
      _minutesController.text = widget.todo!.minutes.toString();
      _secondsController.text = widget.todo!.seconds.toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: whiteFFFFFFColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: textSecondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            CustomText(
              text: widget.isEdit ? editTaskKey : addNewTaskKey,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black000000Color,
            ),

            const SizedBox(height: 6),

            CustomText(
              text: fillDetailsBelowKey,
              fontSize: 13,
              color: textSecondaryColor,
            ),

            const SizedBox(height: 25),

            CustomText(
              text: titleKey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 8),

            CustomTextField(
              hint: enterTaskTitleKey,
              controller: _titleController,
            ),

            const SizedBox(height: 20),

            CustomText(
              text: descriptionKey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 8),

            CustomTextField(
              hint: enterTaskTDescriptionKey,
              maxLines: 3,
              controller: _descriptionController,
            ),

            const SizedBox(height: 20),

            CustomText(
              text: maxTimeKey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: minutesKey,
                        fontSize: 12,
                        color: textSecondaryColor,
                      ),
                      SizedBox(height: 6),
                      CustomTextField(
                        hint: "00",
                        controller: _minutesController,
                        keyboardType: TextInputType.number,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: secondKey,
                        fontSize: 12,
                        color: textSecondaryColor,
                      ),
                      SizedBox(height: 6),
                      CustomTextField(
                        hint: "00",
                        controller: _secondsController,
                        keyboardType: TextInputType.number,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: textSecondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      cancelKey,
                      style: TextStyle(color: black000000Color),
                    ),
                  ),
                ),

                const SizedBox(width: 15),
                BlocListener<TodoCubit, TodoState>(
                  listener: (context, state) {
                    if (state is TodoLoading) {
                      easyLoadingShowProgress(status: pleaseWaitKey);
                    }
                    else if (state is TodoSuccess) {
                      easyLoadingDismiss();
                      easyLoadingShowSuccess(state.message);
                      Future.delayed(const Duration(milliseconds: 500), () {
                        AppRouter.navigatorKey.currentState?.pop();
                      });
                    }
                    else if (state is TodoError) {
                      easyLoadingDismiss();
                      easyLoadingShowError(state.message);
                    }
                  },
                  child: Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple8D15FFColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        final int min =
                            int.tryParse(_minutesController.text) ?? 0;
                        final int sec =
                            int.tryParse(_secondsController.text) ?? 0;
                        final duration = Duration(minutes: min, seconds: sec);

                        if (_titleController.text.trim().isEmpty) {
                          easyLoadingShowError(enterTitleErrorKey);
                          return;
                        }

                        if (_descriptionController.text.trim().isEmpty) {
                          easyLoadingShowError(enterDescriptionErrorKey);
                          return;
                        }

                        if (sec > 59) {
                          easyLoadingShowError(
                            secondsRangeErrorKey,
                          );
                          return;
                        }

                        if (duration == Duration.zero) {
                          easyLoadingShowError(
                            zeroDurationErrorKey,
                          );
                          return;
                        }

                        if (duration > const Duration(minutes: 5)) {
                          easyLoadingShowError(
                            maxDurationErrorKey,
                          );
                          return;
                        }

                        if (widget.isEdit) {
                          context.read<TodoCubit>().updateTodo(
                            index: widget.index!,
                            title: _titleController.text.trim(),
                            description:
                            _descriptionController.text.trim(),
                            minutes: min,
                            seconds: sec,
                          );

                        } else {
                          context.read<TodoCubit>().addTodo(
                            title: _titleController.text.trim(),
                            description:
                            _descriptionController.text.trim(),
                            minutes: min,
                            seconds: sec,
                          );
                        }
                      },
                      child: Text(
                        widget.isEdit ? updateKey : saveKey,
                        style: const TextStyle(color: whiteFFFFFFColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
