import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';
import 'package:nephrogo_api_client/model/user.dart';

import 'nutrition_monthly_summary_list.dart';

enum NutritionSummaryScreenType { weekly, monthly }

class NutritionSummaryScreenArguments {
  final NutritionSummaryScreenType screenType;

  NutritionSummaryScreenArguments(this.screenType);
}

class NutritionSummaryScreen extends StatefulWidget {
  final NutritionSummaryScreenType screenType;

  const NutritionSummaryScreen({Key key, @required this.screenType})
      : assert(screenType != null),
        super(key: key);

  @override
  _NutritionSummaryScreenState createState() => _NutritionSummaryScreenState();
}

class _NutritionSummaryScreenState extends State<NutritionSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _getInitialTabIndex(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.nutritionSummary),
          bottom: TabBar(
            tabs: [
              Tab(text: appLocalizations.weekly.toUpperCase()),
              Tab(text: appLocalizations.monthly.toUpperCase()),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _NutritionSummaryMonthlyScreenBody(),
            _NutritionSummaryMonthlyScreenBody(),
          ],
        ),
      ),
    );
  }

  int _getInitialTabIndex() {
    switch (widget.screenType) {
      case NutritionSummaryScreenType.weekly:
        return 0;
      case NutritionSummaryScreenType.monthly:
        return 1;
    }

    throw ArgumentError.value(widget.screenType);
  }
}

class _NutritionSummaryMonthlyScreenBody extends StatelessWidget {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<User>(
      stream: _apiService.getUserStream(),
      builder: (context, userData) {
        final nutritionSummary = userData.nutritionSummary;
        return Visibility(
          visible: nutritionSummary.minReportDate != null,
          replacement: EmptyStateContainer(
            text: AppLocalizations.of(context).nutritionEmpty,
          ),
          child: MonthlyPager(
            earliestDate: nutritionSummary.minReportDate.toDate(),
            initialDate: nutritionSummary.maxReportDate.toDate(),
            bodyBuilder: (context, header, from, to) {
              return AppFutureBuilder<DailyIntakesReportsResponse>(
                future: _apiService.getLightDailyIntakeReports(from, to),
                builder: (context, data) {
                  return Visibility(
                    visible: data.dailyIntakesLightReports.isNotEmpty,
                    replacement: EmptyStateContainer(
                      text: AppLocalizations.of(context).weeklyNutrientsEmpty,
                    ),
                    child: NutritionMonthlyReportsList(
                      header: header,
                      reports: data.dailyIntakesLightReports.toList(),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
