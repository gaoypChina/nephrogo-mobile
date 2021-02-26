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

class ManualPeritonealDialysisDataGridSource
    extends DataGridSource<ManualPeritonealDialysis> {
  final _dateFormat = DateFormat.MMMMd().add_Hm();

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
        return _dateFormat.format(dialysis.startedAt).capitalizeFirst();
      case 'finishedAt':
        return dialysis.finishedAt != null
            ? _dateFormat.format(dialysis.finishedAt).capitalizeFirst()
            : null;
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

class _AllManualPeritonealDialysisList extends StatefulWidget {
  @override
  _AllManualPeritonealDialysisListState createState() =>
      _AllManualPeritonealDialysisListState();
}

class _AllManualPeritonealDialysisListState
    extends State<_AllManualPeritonealDialysisList> {
  final apiService = ApiService();
  final _numberFormat = NumberFormat.decimalPattern();

  final ColumnSizer _columnSizer = ColumnSizer();

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
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          columnSizer: _columnSizer,
          onQueryRowHeight: (RowHeightDetails rowHeightDetails) {
            final double height =
                _columnSizer.getAutoRowHeight(rowHeightDetails.rowIndex);
            return height;
          },
          columnWidthMode: ColumnWidthMode.auto,
          onQueryCellStyle: (args) {
            final dialysis = allDialysis[args.rowIndex];

            switch (args.column.mappingName) {
              case 'dialysisSolution':
                return DataGridCellStyle(
                  backgroundColor: dialysis.dialysisSolution.color,
                  textStyle: TextStyle(
                    color: dialysis.dialysisSolution.textColor,
                  ),
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
            GridTextColumn(
              mappingName: 'startedAt',
              columnWidthMode: ColumnWidthMode.auto,
              headerText: context.appLocalizations.dialysisStart,
            ),
            GridTextColumn(
              mappingName: 'dialysisSolution',
              headerText: context.appLocalizations.dialysisSolution,
              columnWidthMode: ColumnWidthMode.auto,
              textAlignment: Alignment.center,
            ),
            GridNumericColumn(
              mappingName: 'balance',
              headerText: context.appLocalizations.balance,
              columnWidthMode: ColumnWidthMode.auto,
              numberFormat: _numberFormat,
            ),
            GridNumericColumn(
              mappingName: 'solutionInMl',
              headerText: context.appLocalizations.dialysisSolutionIn,
              columnWidthMode: ColumnWidthMode.auto,
              numberFormat: _numberFormat,
            ),
            GridNumericColumn(
              mappingName: 'solutionOutMl',
              headerText: context.appLocalizations.dialysisSolutionOut,
              columnWidthMode: ColumnWidthMode.auto,
              numberFormat: _numberFormat,
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
              numberFormat: _numberFormat,
            ),
            GridNumericColumn(
              mappingName: 'weight',
              headerText: context.appLocalizations.weight,
              columnWidthMode: ColumnWidthMode.auto,
              numberFormat: _numberFormat,
            ),
            GridNumericColumn(
              mappingName: 'urine',
              headerText: context.appLocalizations.healthStatusCreationUrine,
              columnWidthMode: ColumnWidthMode.auto,
              numberFormat: _numberFormat,
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
            GridTextColumn(
              mappingName: 'finishedAt',
              columnWidthMode: ColumnWidthMode.auto,
              headerText: context.appLocalizations.dialysisEnd,
            ),
          ],
        );
      },
    );
  }
}

class _ManualPeritonealDialysisDailyReportsList extends StatefulWidget {
  @override
  _ManualPeritonealDialysisDailyReportsListState createState() =>
      _ManualPeritonealDialysisDailyReportsListState();
}

class _ManualPeritonealDialysisDailyReportsListState
    extends State<_ManualPeritonealDialysisDailyReportsList> {
  final apiService = ApiService();

  final _dateFormat = DateFormat.MMMMd();
  final _columnSizer = ColumnSizer();

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
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          columnSizer: _columnSizer,
          onQueryRowHeight: (RowHeightDetails rowHeightDetails) {
            return _columnSizer.getAutoRowHeight(rowHeightDetails.rowIndex);
          },
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
            GridTextColumn(
              mappingName: 'pulse',
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
        return report.manualPeritonealDialysis
            .map((d) => d.bloodPressure.formattedAmountWithoutDimension)
            .join('\n');
      case 'pulse':
        return report.manualPeritonealDialysis.map((d) => d.pulse).join('\n');
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
