import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/core/app_easy_loading.dart';
import 'package:flutter_practical_task/logic/cubit/login/login_cubit.dart';
import 'package:flutter_practical_task/router/app_router.dart';
import 'package:flutter_practical_task/ui/widgets/common_text_field.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';
import 'package:hive/hive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8D15FF), Color(0xFFB388FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.task_alt_rounded,
                      size: 70,
                      color: Color(0xFF8D15FF),
                    ),

                    const SizedBox(height: 16),

                    CustomText(
                      text: welcomeBackKey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),

                    const SizedBox(height: 30),
                    CommonTextField(
                      controller: _nameController,
                      label: nameKey,
                      prefixIcon: Icons.person,
                    ),

                    const SizedBox(height: 20),
                    CommonTextField(
                      controller: _emailController,
                      label: emailKey,
                      prefixIcon: Icons.email,
                    ),

                    const SizedBox(height: 20),

                    CommonTextField(
                      controller: _passwordController,
                      label: passwordKey,
                      prefixIcon: Icons.lock,
                    ),

                    const SizedBox(height: 30),

                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginLoading) {
                          easyLoadingShowProgress(status: pleaseWaitKey);
                        } else if (state is LoginError) {
                          easyLoadingShowError(state.message);
                        } else if (state is LoginSuccess) {
                          easyLoadingDismiss();
                          AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
                            AppRouter.todo,
                                (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<LoginCubit>().submitUser(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8D15FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: CustomText(
                              text: loginKey,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
