import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo_api_client/model/daily_manual_peritoneal_dialysis_report.dart';
import 'package:nephrogo_api_client/model/daily_manual_peritoneal_dialysis_report_response.dart';
import 'package:nephrogo_api_client/model/dialysate_color_enum.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ManualPeritonealDialysisDialysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.appLocalizations.peritonealDialysisPlural),
          bottom: TabBar(
            tabs: [
              Tab(text: context.appLocalizations.allFeminine.toUpperCase()),
              Tab(text: context.appLocalizations.daily.toUpperCase()),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _AllManualPeritonealDialysisList(),
            _ManualPeritonealDialysisDailyReportsList(),
          ],
        ),
      ),
    );
  }
}

class _AllManualPeritonealDialysisList extends StatelessWidget {
  final apiService = ApiService();

  final _dateFormat = DateFormat.MMMMd().add_Hm();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<DailyManualPeritonealDialysisReportResponse>(
      stream: apiService.getManualPeritonealDialysisReportsStream(
        Date(2021, 1, 1),
        Date(2021, 10, 10),
      ),
      builder: (context, data) {
        final allDialysis = data.manualPeritonealDialysisReports
            .expand((r) => r.manualPeritonealDialysis)
            .sortedBy((e) => e.startedAt, reverse: true)
            .toList();

        return SfDataGrid(
          source: ManualPeritonealDialysisDataGridSource(
            context.appLocalizations,
            allDialysis,
          ),
          columnWidthMode: ColumnWidthMode.auto,
          onQueryCellStyle: (args) {
            final dialysis = allDialysis[args.rowIndex];

            switch (args.column.mappingName) {
              case 'dialysisSolution':
                return DataGridCellStyle(
                  backgroundColor: dialysis.dialysisSolution.color,
                  textStyle: const TextStyle(color: Colors.white),
                );
              case 'dialysateColor':
                if (dialysis.dialysateColor == null) {
                  return null;
                }
                return DataGridCellStyle(
                  backgroundColor: dialysis.dialysateColor.color,
                  textStyle: TextStyle(
                    color: dialysis.dialysateColor.textColor,
                  ),
                );
            }

            return null;
          },
          columns: <GridColumn>[
            GridDateTimeColumn(
              mappingName: 'startedAt',
              columnWidthMode: ColumnWidthMode.auto,
              headerText: context.appLocalizations.dialysisStart,
              dateFormat: _dateFormat,
            ),
            GridTextColumn(
              mappingName: 'dialysisSolution',
              headerText: context.appLocalizations.dialysisSolution,
              columnWidthMode: ColumnWidthMode.auto,
              textAlignment: Alignment.center,
            ),
            GridTextColumn(
              mappingName: 'balance',
              headerText: context.appLocalizations.balance,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridTextColumn(
              mappingName: 'solutionInMl',
              headerText: context.appLocalizations.dialysisSolutionIn,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridTextColumn(
              mappingName: 'solutionOutMl',
              headerText: context.appLocalizations.dialysisSolutionOut,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridTextColumn(
              mappingName: 'bloodPressure',
              headerText:
                  context.appLocalizations.healthStatusCreationBloodPressure,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridNumericColumn(
              mappingName: 'pulse',
              allowSorting: true,
              headerText: context.appLocalizations.pulse,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridNumericColumn(
              mappingName: 'weight',
              headerText: context.appLocalizations.weight,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridNumericColumn(
              mappingName: 'urine',
              headerText: context.appLocalizations.healthStatusCreationUrine,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridTextColumn(
              mappingName: 'dialysateColor',
              headerText: context.appLocalizations.dialysateColor,
              columnWidthMode: ColumnWidthMode.auto,
              textAlignment: Alignment.center,
            ),
            GridTextColumn(
              mappingName: 'notes',
              headerText: context.appLocalizations.notes,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridDateTimeColumn(
              mappingName: 'finishedAt',
              columnWidthMode: ColumnWidthMode.auto,
              headerText: context.appLocalizations.dialysisEnd,
              dateFormat: _dateFormat,
            ),
          ],
        );
      },
    );
  }
}

class _ManualPeritonealDialysisDailyReportsList extends StatelessWidget {
  final apiService = ApiService();

  final _dateFormat = DateFormat.MMMMd();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<DailyManualPeritonealDialysisReportResponse>(
      stream: apiService.getManualPeritonealDialysisReportsStream(
        Date(2021, 1, 1),
        Date(2021, 10, 10),
      ),
      builder: (context, data) {
        final allDialysis = data.manualPeritonealDialysisReports
            .sortedBy((e) => e.date, reverse: true)
            .toList();

        return SfDataGrid(
          source: ManualPeritonealDialysisDailyReportsDataGridSource(
            context.appLocalizations,
            allDialysis,
          ),
          columnWidthMode: ColumnWidthMode.auto,
          columns: <GridColumn>[
            GridDateTimeColumn(
              mappingName: 'date',
              columnWidthMode: ColumnWidthMode.auto,
              headerText: context.appLocalizations.date,
              dateFormat: _dateFormat,
            ),
            GridNumericColumn(
              mappingName: 'dialysisPerformed',
              headerText: context.appLocalizations.dialysisPerformed,
              columnWidthMode: ColumnWidthMode.auto,
              textAlignment: Alignment.center,
            ),
            GridTextColumn(
              mappingName: 'balance',
              headerText: context.appLocalizations.balance,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridTextColumn(
              mappingName: 'bloodPressure',
              headerText:
                  context.appLocalizations.healthStatusCreationBloodPressure,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridNumericColumn(
              mappingName: 'pulse',
              allowSorting: true,
              headerText: context.appLocalizations.pulse,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridNumericColumn(
              mappingName: 'weight',
              headerText: context.appLocalizations.weight,
              columnWidthMode: ColumnWidthMode.auto,
            ),
            GridNumericColumn(
              mappingName: 'urine',
              headerText: context.appLocalizations.healthStatusCreationUrine,
              columnWidthMode: ColumnWidthMode.auto,
            ),
          ],
        );
      },
    );
  }
}

class ManualPeritonealDialysisDataGridSource
    extends DataGridSource<ManualPeritonealDialysis> {
  final AppLocalizations appLocalizations;
  final List<ManualPeritonealDialysis> dialysis;

  ManualPeritonealDialysisDataGridSource(
    this.appLocalizations,
    Iterable<ManualPeritonealDialysis> dialysis,
  ) : dialysis = dialysis.sortedBy((d) => d.startedAt, reverse: true);

  @override
  List<ManualPeritonealDialysis> get dataSource => dialysis;

  @override
  Object getValue(ManualPeritonealDialysis dialysis, String columnName) {
    switch (columnName) {
      case 'startedAt':
        return dialysis.startedAt;
      case 'finishedAt':
        return dialysis.finishedAt;
      case 'bloodPressure':
        return dialysis.bloodPressure.formattedAmountWithoutDimension;
      case 'pulse':
        return dialysis.pulse.pulse;
      case 'urine':
        return dialysis.urineMl;
      case 'dialysisSolution':
        return dialysis.dialysisSolution.localizedName(appLocalizations);
      case 'solutionInMl':
        return dialysis.solutionInMl;
      case 'solutionOutMl':
        return dialysis.solutionOutMl;
      case 'balance':
        return dialysis.balance;
      case 'weight':
        return dialysis.weightKg;
      case 'dialysateColor':
        return dialysis.dialysateColor
            .enumWithoutDefault(DialysateColorEnum.unknown)
            ?.localizedName(appLocalizations);
      case 'notes':
        return dialysis.notes;
      default:
        return 'empty';
    }
  }
}

class ManualPeritonealDialysisDailyReportsDataGridSource
    extends DataGridSource<DailyManualPeritonealDialysisReport> {
  final AppLocalizations appLocalizations;
  final List<DailyManualPeritonealDialysisReport> reports;

  ManualPeritonealDialysisDailyReportsDataGridSource(
    this.appLocalizations,
    Iterable<DailyManualPeritonealDialysisReport> reports,
  ) : reports = reports.sortedBy((d) => d.date, reverse: true);

  @override
  List<DailyManualPeritonealDialysisReport> get dataSource => reports;

  @override
  Object getValue(
      DailyManualPeritonealDialysisReport report, String columnName) {
    switch (columnName) {
      case 'date':
        return report.date;
      case 'bloodPressure':
        return report.formattedBloodPressures(appLocalizations).join('\n');
      case 'pulse':
        return report.formattedPulses(appLocalizations).join('\n');
      case 'urine':
        return report.urineMl;
      case 'balance':
        return report.totalBalance;
      case 'weight':
        return report.weightKg;
      case 'dialysisPerformed':
        return report.manualPeritonealDialysis.length;
      default:
        return 'empty';
    }
  }
}
