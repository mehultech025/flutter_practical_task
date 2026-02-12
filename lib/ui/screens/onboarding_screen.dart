import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/logic/onboarding/onboarding_cubit.dart';
import 'package:flutter_practical_task/ui/widgets/onboarding_page.dart';
import 'package:flutter_practical_task/utils/constants/constants.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingCubit>().startAnimation(onboardData.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     cubit.restart();
          //     cubit.startAnimation(onboardData.length);
          //   },
          //   child: const Icon(Icons.restart_alt),
          // ),
          body: Stack(
            children: [
              PageView.builder(
                controller: cubit.controller,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  cubit.changePage(index);
                  cubit.startAnimation(onboardData.length);
                },
                itemCount: onboardData.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: onboardData[index].color,
                    child: OnboardingPage(
                      activePage: state.activePage,
                      item: onboardData[index],
                      pageIndex: index,
                    ),
                  );
                },
              ),
              if (state.pageIndex > 0)
                Positioned(
                  top: 50,
                  right: 20,
                  child: SafeArea(
                    child: TextButton(
                      onPressed: () {
                        cubit.skipAll(onboardData.length);
                      },
                      child: const Text(
                        skipKey,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}