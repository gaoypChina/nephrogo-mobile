import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/ui/tabs/health_status/blood_pressure_and_pulse_creation_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_creation_screen.dart';
import 'package:nephrogo/utils/excel_generator.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:open_file/open_file.dart';
import 'package:share/share.dart';

class PeritonealDialysisCreationFloatingActionButton extends StatelessWidget {
  final bool dialysisInProgress;
  final Future<void> Function(BuildContext context) dialysisOnTap;

  const PeritonealDialysisCreationFloatingActionButton({
    Key key,
    @required this.dialysisInProgress,
    @required this.dialysisOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dialysisInProgress) {
      return SpeedDialFloatingActionButton(
        label: _getCreateButtonLabel(context),
        icon: Icons.play_arrow,
        onPress: () => dialysisOnTap(context),
      );
    } else {
      return SpeedDialFloatingActionButton(
        label: _getCreateButtonLabel(context),
        children: [
          _createDialButton(
            icon: Icons.water_damage,
            onTap: () => dialysisOnTap(context),
            backgroundColor: Colors.teal,
            label: context.appLocalizations.peritonealDialysis,
          ),
          _createDialButton(
            icon: Icons.favorite,
            onTap: () => _createBloodPressureOrPulse(context),
            backgroundColor: Colors.deepPurple,
            label: context.appLocalizations.bloodPressureAndPulse,
          ),
          _createDialButton(
            icon: Icons.timeline,
            onTap: () => _createHealthStatus(context),
            backgroundColor: Colors.blue,
            label: context.appLocalizations.weightAndUrine,
          ),
        ],
      );
    }
  }

  String _getCreateButtonLabel(BuildContext context) {
    if (dialysisInProgress) {
      return context.appLocalizations.continueDialysis;
    }

    return context.appLocalizations.startDialysis;
  }

  Future<void> _createHealthStatus(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.routeHealthStatusCreation,
      arguments: HealthStatusCreationScreenArguments(),
    );
  }

  Future<void> _createBloodPressureOrPulse(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.routeBloodPressureAndPulseCreation,
      arguments: BloodPressureAndPulseCreationScreenArguments(),
    );
  }

  SpeedDialChild _createDialButton({
    @required IconData icon,
    @required Color backgroundColor,
    @required String label,
    @required VoidCallback onTap,
  }) {
    return SpeedDialChild(
      child: Icon(icon),
      backgroundColor: backgroundColor,
      labelStyle: const TextStyle(fontSize: 16),
      foregroundColor: Colors.white,
      label: label,
      onTap: onTap,
    );
  }
}

class DialysisSolutionAvatar extends StatelessWidget {
  final DialysisSolutionEnum dialysisSolution;
  final bool isCompleted;
  final bool isDialysateColorNonRegular;
  final double radius;

  const DialysisSolutionAvatar({
    Key key,
    @required this.dialysisSolution,
    this.isCompleted = true,
    this.isDialysateColorNonRegular = false,
    this.radius,
  })  : assert(dialysisSolution != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: dialysisSolution.localizedName(context.appLocalizations),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: dialysisSolution.color,
        foregroundColor: dialysisSolution.textColor,
        child: _getIcon(),
      ),
    );
  }

  Widget _getIcon() {
    if (!isCompleted) {
      return const Icon(Icons.sync_outlined);
    } else if (isDialysateColorNonRegular) {
      return const Icon(Icons.error_outline);
    } else {
      return null;
    }
  }
}

class PeritonealDialysisSummaryFloatingActionButton extends StatelessWidget {
  final Future<ExcelReportBuilder> Function(ExcelReportBuilder builder)
      reportBuilder;

  const PeritonealDialysisSummaryFloatingActionButton({
    Key key,
    @required this.reportBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDialFloatingActionButton(
      label: context.appLocalizations.summary.toUpperCase(),
      icon: Icons.download_rounded,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.open_in_new),
          backgroundColor: Colors.indigo,
          labelStyle: const TextStyle(fontSize: 16),
          foregroundColor: Colors.white,
          label: context.appLocalizations.open,
          onTap: () => _downloadAndExportDialysis(context, false),
        ),
        SpeedDialChild(
          child: const Icon(Icons.share),
          backgroundColor: Colors.teal,
          labelStyle: const TextStyle(fontSize: 16),
          foregroundColor: Colors.white,
          label: context.appLocalizations.send,
          onTap: () => _downloadAndExportDialysis(context, true),
        ),
      ],
    );
  }

  Future<void> _downloadAndExportDialysisInternal(
    BuildContext context,
    bool share,
  ) async {
    final name = 'NephroGo ${context.appLocalizations.summary}';

    final builder = ExcelReportBuilder(context: context);
    final finalReportBuilder = await reportBuilder(builder);

    final file = await finalReportBuilder.buildFile('nephrogo.xlsx');

    if (share) {
      return Share.shareFiles(
        [file.path],
        subject: name,
      );
    } else {
      return OpenFile.open(file.path);
    }
  }

  Future<void> _downloadAndExportDialysis(BuildContext context, bool share) {
    final future =
        _downloadAndExportDialysisInternal(context, share).catchError(
      (e, stackTrace) async {
        FirebaseCrashlytics.instance.recordError(e, stackTrace as StackTrace);

        await showAppDialog(
          context: context,
          title: context.appLocalizations.error,
          content: Text(context.appLocalizations.serverErrorDescription),
        );
      },
    );

    return ProgressDialog(context).showForFuture(future);
  }
}
