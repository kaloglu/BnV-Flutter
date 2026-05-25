import 'package:BedavaNeVar/data/services/shared_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel, bool>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return OnboardingViewModel(sharedPreferencesService.onboarding);
});

class OnboardingViewModel extends StateNotifier<bool> {
  final OnboardingPreferences onboardingPreferences;

  OnboardingViewModel(this.onboardingPreferences) : super(onboardingPreferences.isComplete);

  Future<void> completeOnboarding() async {
    await onboardingPreferences.complete();
    state = true;
  }

  bool get isOnboardingComplete => state;
}
