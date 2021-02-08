import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'nutrition_components.dart';

class MyDailyIntakesReportsScreen extends StatelessWidget {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.myMeals)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AppStreamBuilder<DailyIntakesReportsResponse>(
          stream: _apiService.getLightDailyIntakeReportsStream(),
          builder: (context, data) {
            return Visibility(
              visible: data.dailyIntakesLightReports.isNotEmpty,
              replacement: EmptyStateContainer(
                text: AppLocalizations.of(context).weeklyNutrientsEmpty,
              ),
              child: _MyDailyIntakesReportsNonEmptyListBody(data),
            );
          }),
    );
  }
}

class _MyDailyIntakesReportsNonEmptyListBody extends StatefulWidget {
  final DailyIntakesReportsResponse response;

  const _MyDailyIntakesReportsNonEmptyListBody(
    this.response, {
    Key key,
  }) : super(key: key);

  @override
  _MyDailyIntakesReportsNonEmptyListBodyState createState() =>
      _MyDailyIntakesReportsNonEmptyListBodyState();
}

class _MyDailyIntakesReportsNonEmptyListBodyState
    extends State<_MyDailyIntakesReportsNonEmptyListBody> {
  DateTime minDate;
  DateTime maxDate;
  DateRangePickerController _datePickerController;

  List<DailyIntakesLightReport> _reportsSortedByDateReverse;

  @override
  void initState() {
    _reportsSortedByDateReverse = widget.response.dailyIntakesLightReports
        .sortedBy((e) => e.date, reverse: true)
        .toList();

    minDate = _reportsSortedByDateReverse.last.date;
    maxDate = _reportsSortedByDateReverse.first.date;

    _datePickerController = DateRangePickerController();
    _datePickerController.selectedDate = maxDate;

    super.initState();
  }

  Widget _buildCalendar() {
    final allDates = _reportsSortedByDateReverse.map((r) => Date(r.date));

    final availableDates = allDates.toSet();
    final blackoutDates = DateUtils.generateDates(minDate, maxDate)
        .where((d) => !availableDates.contains(d))
        .toList();

    final dailyNormExceededDates = _reportsSortedByDateReverse
        .where((r) => r.nutrientNormsAndTotals.isAtLeastOneNormExceeded())
        .map((r) => r.date)
        .toList();

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: null,
                icon: Icon(Icons.arrow_drop_down),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hello",
                    // style: TextStyle(fontSize: 13),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              showNavigationArrow: true,
              minDate: minDate,
              maxDate: maxDate,
              controller: _datePickerController,
              monthViewSettings: DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
                showTrailingAndLeadingDates: true,
                blackoutDates: blackoutDates,
                specialDates: dailyNormExceededDates,
              ),
              monthCellStyle: const DateRangePickerMonthCellStyle(
                blackoutDateTextStyle: TextStyle(color: Colors.grey),
                specialDatesDecoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                specialDatesTextStyle: TextStyle(color: Colors.white),
                cellDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Material(
            elevation: 1,
            child: _buildCalendar(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _reportsSortedByDateReverse.length,
            itemBuilder: (context, index) {
              final dailyIntakesReport = _reportsSortedByDateReverse[index];

              return DailyIntakesReportTile(dailyIntakesReport);
            },
          ),
        ),
      ],
    );
  }
}
