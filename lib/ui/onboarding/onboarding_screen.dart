import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/analytics.dart';
import 'package:nephrogo/ui/legal/legal_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_step.dart';

enum OnboardingScreenExitType {
  close,
  legal,
}

class OnboardingScreenArguments {
  final OnboardingScreenExitType exitType;

  OnboardingScreenArguments(this.exitType);
}

class OnboardingScreen extends StatefulWidget {
  final OnboardingScreenExitType exitType;

  const OnboardingScreen({Key key, @required this.exitType})
      : assert(exitType != null),
        super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const stepsCount = 6;
  final _controller = PageController(viewportFraction: 0.9999999);
  int page = 0;

  bool get isDone => page == (stepsCount - 1);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: close,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: CloseButton(onPressed: close),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: stepsCount,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return OnboardingStepComponent(
                        assetName: 'assets/logo/logo-with-title.png',
                        title: appLocalizations.onboardingStep1Title,
                        description:
                            appLocalizations.onboardingStep1Description,
                      );
                    case 1:
                      return OnboardingStepComponent(
                        assetName: 'assets/onboarding/2.png',
                        title: appLocalizations.onboardingStep2Title,
                        description:
                            appLocalizations.onboardingStep2Description,
                      );
                    case 2:
                      return OnboardingStepComponent(
                        assetName: 'assets/onboarding/3.png',
                        title: appLocalizations.onboardingStep3Title,
                        description:
                            appLocalizations.onboardingStep3Description,
                      );
                    case 3:
                      return OnboardingStepComponent(
                        assetName: 'assets/onboarding/4.png',
                        title: appLocalizations.onboardingStep4Title,
                        description:
                            appLocalizations.onboardingStep4Description,
                      );
                    case 4:
                      return OnboardingStepComponent(
                        assetName: 'assets/onboarding/5.png',
                        title: appLocalizations.onboardingStep5Title,
                        description:
                            appLocalizations.onboardingStep5Description,
                      );
                    case 5:
                      return OnboardingStepComponent(
                        assetName: 'assets/onboarding/6.png',
                        title: appLocalizations.onboardingStep6Title,
                        description:
                            appLocalizations.onboardingStep6Description,
                      );
                    default:
                      throw ArgumentError('Illegal index $index');
                  }
                },
                onPageChanged: (int p) {
                  setState(() {
                    page = p;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SmoothPageIndicator(
                controller: _controller,
                count: stepsCount,
                effect: const ScaleEffect(
                  dotColor: Colors.white,
                  activeDotColor: Colors.white,
                  scale: 2,
                  dotWidth: 8,
                  dotHeight: 8,
                  radius: 8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    shape: const StadiumBorder(),
                    side: const BorderSide(width: 2, color: Colors.white),
                  ),
                  onPressed: () => advancePageOrFinish(isDone: isDone),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      isDone
                          ? appLocalizations.finish.toUpperCase()
                          : appLocalizations.further.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future advancePageOrFinish(
      {@required bool isDone, bool skippedOnboarding = false}) async {
    if (isDone) {
      await AppPreferences().setOnboardingPassed();

      if (skippedOnboarding) {
        await Analytics().logOnboardingSkipped();
      } else {
        await Analytics().logOnboardingComplete();
      }

      switch (widget.exitType) {
        case OnboardingScreenExitType.close:
          Navigator.of(context).pop();
          break;
        case OnboardingScreenExitType.legal:
          await Navigator.pushReplacementNamed(
            context,
            Routes.routeLegal,
            arguments: const LegalScreenArguments(LegalScreenExitType.login),
          );
          break;
      }
    } else {
      await _controller.animateToPage(page + 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  Future<bool> close() {
    return advancePageOrFinish(isDone: true, skippedOnboarding: true)
        .then((value) => true);
  }

  @override
  void initState() {
    super.initState();

    Analytics().logOnboardingBegin();
  }
}
