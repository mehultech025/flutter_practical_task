part of 'onboarding_cubit.dart';

class OnboardingState {
  final int pageIndex;
  final int activePage;
  final bool isAnimating;

  const OnboardingState({
    this.pageIndex = 0,
    this.activePage = -1,
    this.isAnimating = false,
  });

  OnboardingState copyWith({
    int? pageIndex,
    int? activePage,
    bool? isAnimating,
  }) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
      activePage: activePage ?? this.activePage,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }
}