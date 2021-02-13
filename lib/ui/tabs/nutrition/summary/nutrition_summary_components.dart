import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/general/components.dart';

class NutritionListWithHeaderEmpty extends StatelessWidget {
  final Widget header;

  const NutritionListWithHeaderEmpty({
    Key key,
    @required this.header,
  })  : assert(header != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateSwitcherHeaderSection(header: header),
        Expanded(
          child: EmptyStateContainer(
            text: AppLocalizations.of(context).weeklyNutrientsEmpty,
          ),
        ),
      ],
    );
  }
}

class DateSwitcherHeaderSection extends StatelessWidget {
  final Widget header;
  final List<Widget> children;

  const DateSwitcherHeaderSection({
    Key key,
    @required this.header,
    this.children,
  })  : assert(header != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicSection(
      header: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: header,
      ),
      showHeaderDivider: true,
      showDividers: true,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children ?? [],
    );
  }
}
