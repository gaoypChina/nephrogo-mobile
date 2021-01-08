// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:nephrolog/extensions/collection_extensions.dart';
// import 'package:nephrolog/extensions/contract_extensions.dart';
// import 'package:nephrolog/l10n/localizations.dart';
// import 'package:nephrolog/models/contract.dart';
// import 'package:nephrolog/models/graph.dart';
// import 'package:nephrolog_api_client/model/daily_intake.dart';
//
// import 'bar_chart.dart';
//
// class TodayNutrientsConsumptionBarChart extends StatelessWidget {
//   final DailyIntake dailyIntake;
//
//   const TodayNutrientsConsumptionBarChart({
//     Key key,
//     this.dailyIntake,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final _appLocalizations = AppLocalizations.of(context);
//
//     final nutrientsWithNorms = Nutrient.values
//         .where((n) => dailyIntake.userIntakeNorms.getNutrientAmount(n) != null)
//         .toList();
//
//     final firstNutrientGroup = nutrientsWithNorms.take(3).toList();
//     final secondNutrientGroup = nutrientsWithNorms.skip(3).toList();
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 100,
//               constraints: BoxConstraints(maxWidth: 250),
//               child: _buildGraph(_appLocalizations, firstNutrientGroup),
//             ),
//           ),
//           if (secondNutrientGroup.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: 100,
//                 constraints: BoxConstraints(maxWidth: 250),
//                 child: _buildGraph(_appLocalizations, secondNutrientGroup),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGraph(AppLocalizations appLocalizations, List<Nutrient> types) {
//     return AppBarChart(
//       data: AppBarChartData(
//         fitInsideHorizontally: false,
//         groups: _buildChartGroups(appLocalizations, types),
//       ),
//     );
//   }
//
//   List<AppBarChartGroup> _buildChartGroups(
//     AppLocalizations appLocalizations,
//     List<Nutrient> types,
//   ) {
//     return types.mapIndexed((i, type) {
//       var dailyNorm = dailyIntake.userIntakeNorms.getNutrientAmount(type);
//       var y = dailyIntake.getNutrientTotalAmount(type);
//
//       if (y == 0 && dailyNorm == null) {
//         dailyNorm = 1;
//       }
//
//       double yPercent = min(y.toDouble() / dailyNorm, 1.0);
//       Color barColor = y > dailyNorm ? Colors.redAccent : Colors.teal;
//       if (y == 0) {
//         barColor = Colors.transparent;
//         yPercent = 1;
//       }
//
//       final formattedTotal = dailyIntake.getNutrientTotalAmountFormatted(type);
//       final formattedDailyNorm =
//           dailyIntake.userIntakeNorms.getNutrientAmountFormatted(type);
//
//       final entry = AppBarChartRod(
//         tooltip: appLocalizations.todayConsumptionWithNormTooltip(
//           formattedTotal,
//           formattedDailyNorm,
//         ),
//         y: yPercent,
//         barColor: barColor,
//         backDrawRodY: 1.0,
//       );
//
//       return AppBarChartGroup(
//         text: type.name(appLocalizations),
//         x: i,
//         rods: [entry],
//       );
//     }).toList();
//   }
// }
