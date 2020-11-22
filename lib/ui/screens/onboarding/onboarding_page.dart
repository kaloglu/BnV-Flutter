import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_viewmodel.dart';
import 'package:BedavaNeVar/ui/widgets/common/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';

class OnboardingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final onboardingViewModel = useProvider(onboardingViewModelProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Herşey BEDAVA! \n\nHergün yenileri eklenen mükemmel listeye göz atmaya ne dersin?',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            FractionallySizedBox(
              widthFactor: 2,
              child: SvgPicture.asset(
                'assets/icons/facebook.svg',
                semanticsLabel: 'BedavaNeVar logo',
                color: Colors.blue,
                colorBlendMode: BlendMode.dstATop,
              ),
            ),
            CustomRaisedButton(
              onPressed: onboardingViewModel.completeOnboarding,
              color: Colors.indigo,
              borderRadius: 30,
              child: Text(
                'Hemen Başla',
                style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
