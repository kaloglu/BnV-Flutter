import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnboardingWidget extends HookWidget {
  const OnboardingWidget({
    Key key,
    this.onBoarding,
    @required this.afterOrSkip,
  }) : super(key: key);
  final WidgetBuilder onBoarding;
  final WidgetBuilder afterOrSkip;

  @override
  Widget build(BuildContext context) {
    if (onBoarding == null || useOnboardingShown()) return afterOrSkip(context);
    return onBoarding(context);
  }
}
