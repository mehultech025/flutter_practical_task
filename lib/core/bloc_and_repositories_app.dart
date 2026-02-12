import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/logic/cubit/internet/internet_cubit.dart';
import 'package:flutter_practical_task/logic/onboarding/onboarding_cubit.dart';
import 'package:flutter_practical_task/main.dart';

/// Add app level repositories and cubits.
class BlocAndRepositoryApp extends StatelessWidget {
  const BlocAndRepositoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InternetCubit(),
          ),
          BlocProvider(
            create: (context) => OnboardingCubit(),
          ),
        ],
        child: MyApp(),
      );
  }
}
