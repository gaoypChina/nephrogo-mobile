import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/peritoneal_dialysis_components.dart';
import 'package:nephrogo_api_client/model/automatic_peritoneal_dialysis.dart';

import 'automatic_peritoneal_dialysis_creation_screen.dart';

class AutomaticPeritonealDialysisTile extends StatelessWidget {
  final AutomaticPeritonealDialysis dialysis;
  final _dateTimeFormat = DateFormat.MMMMd().add_Hm();

  AutomaticPeritonealDialysisTile(this.dialysis)
      : assert(dialysis != null),
        super(key: ObjectKey(dialysis));

  @override
  Widget build(BuildContext context) {
    final subtitleWidgets =
        _getSubtitleWidgets(context.appLocalizations).toList();

    final solutionTiles = _getSolutionTiles(context.appLocalizations).toList();

    return Column(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          AppListTile(
            title: Text(_getTitle(context.appLocalizations)),
            leading: _getIconAvatar(),
            subtitle: subtitleWidgets.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: subtitleWidgets,
                  )
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (dialysis.isCompleted)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(dialysis.formattedBalance),
                  ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () => Navigator.of(context).pushNamed(
              Routes.routeAutomaticPeritonealDialysisCreation,
              arguments:
                  AutomaticPeritonealDialysisCreationScreenArguments(dialysis),
            ),
          ),
          ...solutionTiles
        ],
      ).toList(),
    );
  }

  Iterable<Widget> _getSolutionTiles(AppLocalizations appLocalizations) sync* {
    for (final solution in dialysis.getSolutionsUsed()) {
      yield AppListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DialysisSolutionAvatar(
              dialysisSolution: solution,
              radius: 10.0,
            ),
          ),
        ),
        title: Text(solution.localizedName(appLocalizations)),
        dense: true,
        trailing: Text(dialysis.getSolutionVolumeFormatted(solution)),
      );
    }
  }

  CircleAvatar _getIconAvatar() {
    if (!dialysis.isCompleted) {
      return const CircleAvatar(
        child: Icon(Icons.sync_outlined),
      );
    } else if (dialysis.isDialysateColorNonRegular) {
      return const CircleAvatar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        child: Icon(Icons.error_outline),
      );
    } else {
      return const CircleAvatar(
        child: Icon(Icons.done),
      );
    }
  }

  Iterable<Widget> _getSubtitleWidgets(
    AppLocalizations appLocalizations,
  ) sync* {
    if (dialysis.isDialysateColorNonRegular) {
      yield Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.error_outline, size: 14),
            ),
            Text(dialysis.dialysateColor.localizedName(appLocalizations)),
          ],
        ),
      );
    }

    if (dialysis.notes.isNotEmpty) {
      yield Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(dialysis.notes),
      );
    }
  }

  String _getTitle(AppLocalizations appLocalizations) {
    return _dateTimeFormat
        .format(dialysis.startedAt.toLocal())
        .capitalizeFirst();
  }
}
