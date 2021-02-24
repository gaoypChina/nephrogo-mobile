import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/manual_peritoneal_dialysis/extensions/dialysis_contract_extensions.dart';
import 'package:nephrogo_api_client/model/daily_manual_peritoneal_dialysis_report_response.dart';
import 'package:nephrogo_api_client/model/dialysate_color_enum.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ManualPeritonealDialysisTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDialFloatingActionButton(
        label: "PRADĖTI DIALIZĘ",
        onPress: () => _openDialysisCreation(context),
      ),
      body: ManualPeritonealDialysisList(),
    );
  }

  Future<void> _openDialysisCreation(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(Routes.routeManualPeritonealDialysisCreation);
  }
}

class ManualPeritonealDialysisList extends StatelessWidget {
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
            .sortedBy(
              (e) => e.startedAt,
              reverse: true,
            )
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
              headerText: context.appLocalizations.start,
              dateFormat: _dateFormat,
            ),
            GridTextColumn(
              mappingName: 'dialysisSolution',
              headerText: context.appLocalizations.dialysisSolution,
              columnWidthMode: ColumnWidthMode.auto,
              textAlignment: Alignment.center,
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
              headerText: context.appLocalizations.end,
              dateFormat: _dateFormat,
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
