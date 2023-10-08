import 'package:flutter/material.dart';

class OnboardingStepComponent extends StatelessWidget {
  final String assetName;
  final String title;
  final String description;
  final Color? imageColor;
  final Color? fontColor;

  const OnboardingStepComponent({
    super.key,
    required this.assetName,
    required this.title,
    required this.description,
    this.imageColor,
    this.fontColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.asset(
              assetName,
              color: imageColor,
              fit: BoxFit.contain,
              excludeFromSemantics: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: fontColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: fontColor,
                    fontSize: 16,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
