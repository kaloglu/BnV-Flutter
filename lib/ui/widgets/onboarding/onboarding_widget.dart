import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_viewmodel.dart';

class OnboardingWidget extends HookConsumerWidget {
  const OnboardingWidget({
    super.key,
    this.onBoarding,
    required this.afterOrSkip,
  });
  final WidgetBuilder? onBoarding;
  final WidgetBuilder afterOrSkip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isComplete = ref.watch(onboardingViewModelProvider);
    if (onBoarding == null || isComplete) return afterOrSkip(context);
    return onBoarding!(context);
  }
}
