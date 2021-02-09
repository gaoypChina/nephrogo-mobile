import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'nutrition_calendar.dart';
import 'nutrition_components.dart';

class NutritionSummaryScreen extends StatefulWidget {
  @override
  _NutritionSummaryScreenState createState() => _NutritionSummaryScreenState();
}

class _NutritionSummaryScreenState extends State<NutritionSummaryScreen>
    with SingleTickerProviderStateMixin {
  final _apiService = ApiService();

  AnimationController _hideFabAnimation;

  ItemScrollController _itemScrollController;

  DateRangePickerController _datePickerController;

  @override
  void initState() {
    super.initState();

    _itemScrollController = ItemScrollController();

    _datePickerController = DateRangePickerController();

    _hideFabAnimation = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(title: Text(appLocalizations.nutritionSummary)),
        floatingActionButton: ScaleTransition(
          scale: _hideFabAnimation,
          child: FloatingActionButton(
            heroTag: 'scrollToTop',
            onPressed: () {
              _hideFabAnimation.reverse();
              _itemScrollController.jumpTo(index: 0);
            },
            child: const Icon(Icons.keyboard_arrow_up),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: AppStreamBuilder<DailyIntakesReportsResponse>(
            stream: _apiService.getLightDailyIntakeReportsStream(),
            builder: (context, data) {
              return Visibility(
                visible: data.dailyIntakesLightReports.isNotEmpty,
                replacement: EmptyStateContainer(
                  text: AppLocalizations.of(context).weeklyNutrientsEmpty,
                ),
                child: _buildList(data.dailyIntakesLightReports),
              );
            }),
      ),
    );
  }

  Widget _buildList(Iterable<DailyIntakesLightReport> reports) {
    final reportsReverseSorted =
        reports.sortedBy((e) => e.date, reverse: true).toList();

    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: reportsReverseSorted.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return BasicSection.single(
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NutritionCalendar(
                  reportsReverseSorted,
                  datePickerController: _datePickerController,
                  onSelectionChanged: (dt) =>
                      _onSelectionChanged(dt, reportsReverseSorted),
                ),
              ),
            ),
          );
        }
        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return DailyIntakesReportTile(dailyIntakesReport);
      },
    );
  }

  void _onSelectionChanged(
    DateTime dateTime,
    List<DailyIntakesLightReport> reports,
  ) {
    final position = getReportPosition(dateTime, reports);

    _itemScrollController.jumpTo(index: position);
  }

  int getReportPosition(
    DateTime dateTime,
    List<DailyIntakesLightReport> reports,
  ) {
    return reports
            .mapIndexed((i, r) => r.date == Date(dateTime) ? i : null)
            .firstWhere((i) => i != null) +
        1;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0 && notification is UserScrollNotification) {
      final UserScrollNotification userScroll = notification;
      switch (userScroll.direction) {
        case ScrollDirection.forward:
          if (userScroll.metrics.maxScrollExtent !=
              userScroll.metrics.minScrollExtent) {
            _hideFabAnimation.forward();
          }
          break;
        case ScrollDirection.reverse:
          if (userScroll.metrics.maxScrollExtent !=
              userScroll.metrics.minScrollExtent) {
            _hideFabAnimation.reverse();
          }
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    _datePickerController.dispose();

    super.dispose();
  }
}
