import 'package:flutter/material.dart';
import 'package:flutter_practical_task/router/app_router.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      _initApp();
    });

  }

Future<void> _initApp() async {
  AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    AppRouter.onboarding,
        (route) => false,
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.flutter_dash,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            Text(
              splashKey,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
