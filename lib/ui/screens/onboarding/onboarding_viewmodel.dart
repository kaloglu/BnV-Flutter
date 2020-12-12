import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/data/services/shared_preferences_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return OnboardingViewModel(sharedPreferencesService.onboardingPreferences);
});

ValueNotifier<bool> useOnboardingListener() {
  final viewModel = useProvider(onboardingViewModelProvider);
  final _isCompleted = useState(viewModel.isOnboardingComplete);

  useEffect(
    () => viewModel.stream.listen((isCompleted) => _isCompleted.value = isCompleted).cancel,
    [viewModel.stream],
  );
  return _isCompleted;
}

class OnboardingViewModel extends StateNotifier<bool> {
  final OnboardingPreferences onboardingPreferences;

  OnboardingViewModel(this.onboardingPreferences) : super(onboardingPreferences.isComplete());

  Future<void> completeOnboarding() async {
    await onboardingPreferences.setComplete();
    state = true;
  }

  bool get isOnboardingComplete => state;
}
