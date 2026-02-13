import 'package:flutter/material.dart';
import 'package:flutter_practical_task/router/app_router.dart';
import 'package:flutter_practical_task/ui/widgets/custom_text.dart';
import 'package:flutter_practical_task/utils/constants/fonts/fonts_weight.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 5));
      _initApp();
    });
  }

  Future<void> _initApp() async {

    final authBox = Hive.box('auth');
    bool isLogin = authBox.get('isLogin', defaultValue: false);
    if (isLogin) {
      AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRouter.todo,
            (route) => false,
      );
    } else {
      AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRouter.onboarding,
            (route) => false,
      );
    }
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt_rounded, size: 90, color: Colors.white),
              SizedBox(height: 20),
              CustomText(
                text: todoManagerKey,
                color: Colors.white,
                fontSize: 26,
                fontWeight: bold,
              ),

              SizedBox(height: 8),
              CustomText(
                text: todoManagerTaskKey,
                color: Colors.white70,
                fontSize: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
