import 'package:BedavaNeVar/data/services/shared_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return OnboardingViewModel(sharedPreferencesService.onboardingPreferences);
});

class OnboardingViewModel extends StateNotifier<bool> {
  OnboardingViewModel(this.onboardingPreferences) : super(onboardingPreferences.isComplete());
  final OnboardingPreferences onboardingPreferences;

  Future<void> completeOnboarding() async {
    await onboardingPreferences.setComplete();
    state = true;
  }

  bool get isOnboardingComplete => state;
}
