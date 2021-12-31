import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/automatic/automatic_peritoneal_dialysis_creation_screen.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/peritoneal_dialysis_components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class AutomaticPeritonealDialysisTile extends StatelessWidget {
  final AutomaticPeritonealDialysis dialysis;
  final _dateTimeFormat = DateFormat.MMMMd().add_Hm();

  AutomaticPeritonealDialysisTile(this.dialysis)
      : super(key: ObjectKey(dialysis));

  @override
  Widget build(BuildContext context) {
    final subtitleWidgets = _getSubtitleWidgets(context.appLocalizations);

    final solutionTiles = _getSolutionTiles(context.appLocalizations).toList();

    return Column(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          AppListTile(
            title: Text(_getTitle(context.appLocalizations)),
            leading: _getIconAvatar(),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final child in subtitleWidgets)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: child,
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (dialysis.isCompleted == true)
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
    if (dialysis.isCompleted != true) {
      return const CircleAvatar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
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
    if (dialysis.isCompleted == true && dialysis.finishedAt != null) {
      yield Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(Icons.update, size: 14),
          ),
          Text(_dateTimeFormat
              .format(dialysis.finishedAt!.toLocal())
              .capitalizeFirst()),
        ],
      );
    } else {
      yield Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(Icons.info_outline, size: 14),
          ),
          Text(appLocalizations.dialysisActive),
        ],
      );
    }

    if (dialysis.isDialysateColorNonRegular) {
      yield Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(Icons.error_outline, size: 14),
          ),
          Text(dialysis.dialysateColor!.localizedName(appLocalizations)),
        ],
      );
    }

    if (dialysis.notes != null && dialysis.notes!.isNotEmpty) {
      yield Text(dialysis.notes!);
    }
  }

  String _getTitle(AppLocalizations appLocalizations) {
    return _dateTimeFormat
        .format(dialysis.startedAt.toLocal())
        .capitalizeFirst();
  }
}
