import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/analytics.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_step.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const STEPS_COUNT = 6;
  final _controller = new PageController(viewportFraction: 0.9999999);
  int page = 0;

  get isDone => page == (STEPS_COUNT - 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () => advancePageOrFinish(true, skippedOnboarding: true),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            child: Text(
              isDone
                  ? appLocalizations.finish.toUpperCase()
                  : appLocalizations.next.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => advancePageOrFinish(isDone),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: STEPS_COUNT,
              itemBuilder: (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return OnboardingStepComponent(
                      assetName: "assets/logo/logo-with-title.png",
                      title: appLocalizations.onboardingStep1Title,
                      description: appLocalizations.onboardingStep1Description,
                    );
                  case 1:
                    return OnboardingStepComponent(
                      assetName: "assets/onboarding/2.png",
                      title: appLocalizations.onboardingStep2Title,
                      description: appLocalizations.onboardingStep2Description,
                    );
                  case 2:
                    return OnboardingStepComponent(
                      assetName: "assets/onboarding/3.png",
                      title: appLocalizations.onboardingStep3Title,
                      description: appLocalizations.onboardingStep3Description,
                    );
                  case 3:
                    return OnboardingStepComponent(
                      assetName: "assets/onboarding/4.png",
                      title: appLocalizations.onboardingStep4Title,
                      description: appLocalizations.onboardingStep4Description,
                    );
                  case 4:
                    return OnboardingStepComponent(
                      assetName: "assets/onboarding/5.png",
                      title: appLocalizations.onboardingStep5Title,
                      description: appLocalizations.onboardingStep5Description,
                    );
                  case 5:
                    return OnboardingStepComponent(
                      assetName: "assets/onboarding/6.png",
                      title: appLocalizations.onboardingStep6Title,
                      description: appLocalizations.onboardingStep6Description,
                    );
                  default:
                    throw ArgumentError("Illegal index $index");
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
              count: STEPS_COUNT,
              effect: ScaleEffect(
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
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: new Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.white, width: 1.0),
                  color: Colors.transparent,
                ),
                child: Material(
                  child: MaterialButton(
                    child: Text(
                      isDone
                          ? appLocalizations.finish.toUpperCase()
                          : appLocalizations.next.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () {
                      advancePageOrFinish(isDone);
                    },
                    highlightColor: Colors.white30,
                    splashColor: Colors.white30,
                  ),
                  color: Colors.transparent,
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  advancePageOrFinish(bool isDone, {skippedOnboarding: false}) async {
    if (isDone) {
      // await AppPreferences().setOnboardingPassed();

      if (skippedOnboarding) {
        await Analytics().logOnboardingSkipped();
      } else {
        await Analytics().logOnboardingComplete();
      }

      Navigator.pop(context);

      // final selectedPetType = await AppPreferences().getSelectedPetType();

      // if (selectedPetType != null) {
      //   Navigator.pop(context);
      // } else {
      //   Navigator.pushReplacementNamed(
      //     context,
      //     Routes.ROUTE_PREFERENCES,
      //   );
      // }
    } else {
      _controller.animateToPage(page + 1,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  void initState() {
    super.initState();

    Analytics().logOnboardingBegin();
  }
}
