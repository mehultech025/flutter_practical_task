import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practical_task/router/app_router.dart';
part 'onboarding_state.dart';


class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  final PageController controller = PageController();
  bool _hasNavigated = false;

  Future<void> startAnimation(int totalPages) async {
    // Hide subtitle
    emit(state.copyWith(activePage: -1));

    await Future.delayed(const Duration(milliseconds: 600));

    // Show subtitle
    emit(state.copyWith(activePage: state.pageIndex));

    await Future.delayed(const Duration(seconds: 2));

    // Move to next page
    if (state.pageIndex < totalPages - 1) {
      await controller.animateToPage(
        state.pageIndex + 1,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }else{
      if (!_hasNavigated) {
        _hasNavigated = true;
        AppRouter.navigatorKey.currentState?.pushReplacementNamed(
          AppRouter.todo,
        );
      }
    }
  }

  Future<void> skipAll(int totalPages) async {
    await controller.animateToPage(
      totalPages - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
  void changePage(int index) {
    emit(state.copyWith(pageIndex: index));
  }

  void restart() {
    controller.jumpToPage(0);
    emit(const OnboardingState());
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}