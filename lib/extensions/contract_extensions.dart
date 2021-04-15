import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/collection_extensions.dart';
import 'package:nephrogo/extensions/date_extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:tuple/tuple.dart';

final _numberFormatter = NumberFormat.decimalPattern();

String _formatAmount<T extends num>(T amount, String dim) {
  if (amount is double && amount < 1000) {
    final roundedDouble = (amount * 100).round() / 100;

    return '${_numberFormatter.format(roundedDouble)} $dim';
  }

  return '${_numberFormatter.format(amount)} $dim';
}

String _formatAmountNoDim<T extends num>(T amount) {
  return _formatAmount(amount, '').trim();
}

extension ProductExtensions on Product {
  num _getNutrientAmount(Nutrient nutrient) {
    switch (nutrient) {
      case Nutrient.potassium:
        return potassiumMg;
      case Nutrient.proteins:
        return proteinsMg;
      case Nutrient.sodium:
        return sodiumMg;
      case Nutrient.phosphorus:
        return phosphorusMg;
      case Nutrient.liquids:
        return liquidsMl;
      case Nutrient.energy:
        return energyKcal;
      case Nutrient.fat:
        return fatMg;
      case Nutrient.carbohydrate:
        return carbohydratesMg;
    }
  }

  int _calculateTotalNutrientAmount(Nutrient nutrient, int amountG) {
    final nutrientAmount = _getNutrientAmount(nutrient);
    final nutrientAmountRatio = amountG / 100;

    return (nutrientAmount * nutrientAmountRatio).round();
  }

  String getFormattedTotalAmount(Nutrient nutrient, int amountG) {
    final nutrientAmount = _calculateTotalNutrientAmount(nutrient, amountG);

    return nutrient.formatAmount(nutrientAmount);
  }

  int getNutrientNormPercentage(Nutrient nutrient, int amountG, int norm) {
    return ((_calculateTotalNutrientAmount(nutrient, amountG) / norm) * 100)
        .round();
  }

  bool get isDrink => productKind == ProductKindEnum.drink;

  // This is used for generating intakes required to show nutrient amounts
  // after searching for a product
  Intake fakeIntake({
    required DateTime consumedAt,
    required MealTypeEnum mealType,
    int? id,
    int amountG = 0,
    int? amountMl,
  }) {
    final builder = IntakeBuilder();

    builder.id = id ?? 0;
    builder.consumedAt = consumedAt;

    builder.amountG = amountG;

    builder.mealType = mealType;

    if (densityGMl != null) {
      if (amountMl != null) {
        builder.amountMl = amountMl;
      } else {
        builder.amountMl = (amountG / densityGMl!).round();
      }
    }

    builder.potassiumMg =
        _calculateTotalNutrientAmount(Nutrient.potassium, amountG);
    builder.proteinsMg =
        _calculateTotalNutrientAmount(Nutrient.proteins, amountG);
    builder.sodiumMg = _calculateTotalNutrientAmount(Nutrient.sodium, amountG);
    builder.phosphorusMg =
        _calculateTotalNutrientAmount(Nutrient.phosphorus, amountG);
    builder.energyKcal =
        _calculateTotalNutrientAmount(Nutrient.energy, amountG);
    builder.liquidsMl =
        _calculateTotalNutrientAmount(Nutrient.liquids, amountG);
    builder.carbohydratesMg =
        _calculateTotalNutrientAmount(Nutrient.carbohydrate, amountG);
    builder.fatMg = _calculateTotalNutrientAmount(Nutrient.fat, amountG);

    builder.product = toBuilder();

    return builder.build();
  }
}

extension DailyNutrientConsumptionExtensions on DailyNutrientConsumption {
  int? totalConsumptionRoundedPercentage() {
    if (norm == null) {
      return null;
    }

    return ((total / norm!) * 100).round();
  }

  double? get normPercentage {
    if (norm == null) {
      return null;
    }

    return total / norm!;
  }

  int? normPercentageRounded(int nutrientAmount) {
    if (norm == null) {
      return null;
    }

    return ((nutrientAmount / norm!) * 100).round();
  }

  bool get isNormExists => norm != null;

  bool? get normExceeded {
    if (norm == null) {
      return null;
    }

    return total > norm!;
  }
}

extension DailyIntakesReportExtensions on DailyIntakesReport {
  DailyIntakesLightReport toLightReport() {
    final builder = DailyIntakesLightReportBuilder();

    builder.nutrientNormsAndTotals = dailyNutrientNormsAndTotals.toBuilder();
    builder.date = date;

    return builder.build();
  }

  Iterable<Tuple2<MealTypeEnum, List<Intake>>>
      getIntakesGroupedByMealType() sync* {
    final sortedIntakes = intakes.orderBy((i) => i.consumedAt, reverse: true);
    final groups = sortedIntakes.groupBy((intake) => intake.mealType);

    final mealTypes = [
      MealTypeEnum.dinner,
      MealTypeEnum.lunch,
      MealTypeEnum.breakfast,
      MealTypeEnum.snack,
      MealTypeEnum.unknown,
    ];

    for (final mealType in mealTypes) {
      if (groups.containsKey(mealType)) {
        yield Tuple2(mealType, groups[mealType]!);
      } else if (mealType != MealTypeEnum.unknown) {
        yield Tuple2(mealType, []);
      }
    }
  }

  Iterable<DailyMealTypeNutrientConsumption> dailyMealTypeNutrientConsumptions({
    required Nutrient nutrient,
    bool includeEmpty = false,
  }) sync* {
    final dailyTotal =
        intakes.sumBy((e) => e.getNutrientAmount(nutrient)).toInt();
    final groups = intakes.groupBy((intake) => intake.mealType);

    final mealTypes = [
      ...MealTypeEnum.values.where((e) => e != MealTypeEnum.unknown).toList(),
      MealTypeEnum.unknown
    ];

    for (final mealType in mealTypes) {
      if (groups.containsKey(mealType)) {
        final group = groups[mealType]!;

        final drinksTotal = group
            .where((i) => i.product.isDrink)
            .sumBy((e) => e.getNutrientAmount(nutrient))
            .toInt();
        final foodTotal = group
            .where((i) => !i.product.isDrink)
            .sumBy((e) => e.getNutrientAmount(nutrient))
            .toInt();

        yield DailyMealTypeNutrientConsumption(
          date: Date.from(date),
          nutrient: nutrient,
          mealType: mealType,
          drinksTotal: drinksTotal,
          foodTotal: foodTotal,
          dailyTotal: dailyTotal,
        );
      } else if (includeEmpty && mealType != MealTypeEnum.unknown) {
        yield DailyMealTypeNutrientConsumption(
          date: Date.from(date),
          nutrient: nutrient,
          mealType: mealType,
          drinksTotal: 0,
          foodTotal: 0,
          dailyTotal: dailyTotal,
        );
      }
    }
  }
}

extension MealTypeExtensions on MealTypeEnum {
  String localizedName(AppLocalizations appLocalizations) {
    switch (this) {
      case MealTypeEnum.breakfast:
        return appLocalizations.breakfast;
      case MealTypeEnum.lunch:
        return appLocalizations.lunch;
      case MealTypeEnum.dinner:
        return appLocalizations.dinner;
      case MealTypeEnum.snack:
        return appLocalizations.snacks;
      case MealTypeEnum.unknown:
        return appLocalizations.otherMeals;
    }
    throw ArgumentError.value(this, 'mealType', 'Unable to map mealType');
  }

  IconData get icon {
    switch (this) {
      case MealTypeEnum.breakfast:
        return Icons.breakfast_dining;
      case MealTypeEnum.lunch:
        return Icons.dinner_dining;
      case MealTypeEnum.dinner:
        return Icons.nights_stay;
      case MealTypeEnum.snack:
        return Icons.bakery_dining;
      case MealTypeEnum.unknown:
        return Icons.local_dining;
    }
    throw ArgumentError.value(this, 'mealType', 'Unable to map mealType');
  }
}

extension DailyNutrientNormsWithTotalsExtensions
    on DailyNutrientNormsWithTotals {
  DailyNutrientConsumption getDailyNutrientConsumption(Nutrient nutrient) {
    switch (nutrient) {
      case Nutrient.potassium:
        return potassiumMg;
      case Nutrient.proteins:
        return proteinsMg;
      case Nutrient.sodium:
        return sodiumMg;
      case Nutrient.phosphorus:
        return phosphorusMg;
      case Nutrient.liquids:
        return liquidsMl;
      case Nutrient.energy:
        return energyKcal;
      case Nutrient.fat:
        return fatMg;
      case Nutrient.carbohydrate:
        return carbohydratesMg;
    }
  }

  String getNutrientTotalAmountFormatted(Nutrient nutrient) {
    final amount = getDailyNutrientConsumption(nutrient).total;

    return nutrient.formatAmount(amount);
  }

  String? getNutrientNormFormatted(Nutrient nutrient) {
    final norm = getDailyNutrientConsumption(nutrient).norm;
    if (norm == null) {
      return null;
    }

    return nutrient.formatAmount(norm);
  }

  String getNutrientTotalAmountFormattedNoDim(Nutrient nutrient) {
    final total = getDailyNutrientConsumption(nutrient).total;

    return nutrient.formatAmountNoDim(total);
  }

  String? getNutrientUsedWithPercentageFormatted(Nutrient nutrient) {
    final consumption = getDailyNutrientConsumption(nutrient);
    final totalFormatted = getNutrientTotalAmountFormattedNoDim(nutrient);
    final norm = consumption.norm;

    if (norm != null) {
      final normFormatted = nutrient.formatAmount(norm);

      final percentageFormatted =
          NumberFormat.percentPattern().format(consumption.normPercentage);

      return '$percentageFormatted ($totalFormatted / $normFormatted)';
    }

    return null;
  }

  int? getRoundedNormPercentage(Nutrient nutrient) {
    final consumption = getDailyNutrientConsumption(nutrient);

    if (consumption.norm == null) {
      return null;
    }

    return ((consumption.total / consumption.norm!) * 100).round();
  }

  int normsExceededCount() {
    return Nutrient.values
        .map(getDailyNutrientConsumption)
        .where((c) => c.normExceeded == true)
        .length;
  }

  bool isAtLeastOneNormExceeded() {
    return Nutrient.values
        .map(getDailyNutrientConsumption)
        .any((c) => c.normExceeded == true);
  }

  bool isAtLeastOneTotalNonZeo() {
    return Nutrient.values
        .map(getDailyNutrientConsumption)
        .any((c) => c.total != 0);
  }

  List<Nutrient> getSortedNutrientsByExistence() {
    return Nutrient.values
        .orderBy((n) => getDailyNutrientConsumption(n).isNormExists ? 0 : 1)
        .toList();
  }
}

extension IntakeExtension on Intake {
  int getNutrientAmount(Nutrient nutrient) {
    switch (nutrient) {
      case Nutrient.energy:
        return energyKcal;
      case Nutrient.liquids:
        return liquidsMl;
      case Nutrient.proteins:
        return proteinsMg;
      case Nutrient.sodium:
        return sodiumMg;
      case Nutrient.potassium:
        return potassiumMg;
      case Nutrient.phosphorus:
        return phosphorusMg;
      case Nutrient.fat:
        return fatMg;
      case Nutrient.carbohydrate:
        return carbohydratesMg;
    }
  }

  String getNutrientAmountFormatted(Nutrient nutrient) {
    final amount = getNutrientAmount(nutrient);

    return nutrient.formatAmount(amount);
  }

  String getAmountFormatted() {
    if (amountMl != null) {
      return _formatAmount(amountMl!, 'ml');
    }

    return _formatAmount(amountG, 'g');
  }
}

extension NutrientExtensions on Nutrient {
  String name(AppLocalizations appLocalizations) {
    switch (this) {
      case Nutrient.energy:
        return appLocalizations.energy;
      case Nutrient.liquids:
        return appLocalizations.liquids;
      case Nutrient.proteins:
        return appLocalizations.proteins;
      case Nutrient.sodium:
        return appLocalizations.sodium;
      case Nutrient.potassium:
        return appLocalizations.potassium;
      case Nutrient.phosphorus:
        return appLocalizations.phosphorus;
      case Nutrient.fat:
        return appLocalizations.fat;
      case Nutrient.carbohydrate:
        return appLocalizations.carbohydrate;
    }
  }

  String consumptionName(AppLocalizations appLocalizations) {
    switch (this) {
      case Nutrient.energy:
        return appLocalizations.consumptionEnergy;
      case Nutrient.liquids:
        return appLocalizations.consumptionLiquids;
      case Nutrient.proteins:
        return appLocalizations.consumptionProteins;
      case Nutrient.sodium:
        return appLocalizations.consumptionSodium;
      case Nutrient.potassium:
        return appLocalizations.consumptionPotassium;
      case Nutrient.phosphorus:
        return appLocalizations.consumptionPhosphorus;
      case Nutrient.fat:
        return appLocalizations.consumptionFat;
      case Nutrient.carbohydrate:
        return appLocalizations.consumptionCarbohydrate;
    }
  }

  String formatAmount(int amount) {
    return _formatAmount(amount * scale, scaledDimension);
  }

  String formatAmountNoDim(int amount) {
    return _formatAmountNoDim(amount * scale);
  }

  num get scale {
    switch (this) {
      case Nutrient.energy:
      case Nutrient.liquids:
        return 1;
      default:
        return 1e-3;
    }
  }

  int get decimalPlaces {
    switch (this) {
      case Nutrient.energy:
      case Nutrient.liquids:
        return 0;
      default:
        return 2;
    }
  }

  String get scaledDimension {
    switch (this) {
      case Nutrient.energy:
        return 'kcal';
      case Nutrient.proteins:
      case Nutrient.sodium:
      case Nutrient.potassium:
      case Nutrient.phosphorus:
      case Nutrient.fat:
      case Nutrient.carbohydrate:
        return 'g';
      case Nutrient.liquids:
        return 'ml';
    }
  }
}

extension SwellingExtension on Swelling {
  String? getLocalizedName(AppLocalizations appLocalizations) {
    switch (swelling) {
      case SwellingEnum.eyes:
        return appLocalizations.healthStatusCreationSwellingsLocalizationEyes;
      case SwellingEnum.wholeFace:
        return appLocalizations
            .healthStatusCreationSwellingsLocalizationWholeFace;
      case SwellingEnum.handBreadth:
        return appLocalizations
            .healthStatusCreationSwellingsLocalizationHandBreadth;
      case SwellingEnum.hands:
        return appLocalizations.healthStatusCreationSwellingsLocalizationHands;
      case SwellingEnum.belly:
        return appLocalizations.healthStatusCreationSwellingsLocalizationBelly;
      case SwellingEnum.knees:
        return appLocalizations.healthStatusCreationSwellingsLocalizationKnees;
      case SwellingEnum.foot:
        return appLocalizations.healthStatusCreationSwellingsLocalizationFoot;
      case SwellingEnum.wholeLegs:
        return appLocalizations
            .healthStatusCreationSwellingsLocalizationWholeLegs;
      case SwellingEnum.unknown:
        return null;
    }
    throw ArgumentError.value(
      swelling,
      'swelling',
      'Invalid swelling value',
    );
  }
}

extension BloodPressureExtensions on BloodPressure {
  BloodPressureRequestBuilder toRequestBuilder() {
    final builder = BloodPressureRequestBuilder();

    builder.diastolicBloodPressure = diastolicBloodPressure;
    builder.systolicBloodPressure = systolicBloodPressure;
    builder.measuredAt = measuredAt.toUtc();

    return builder;
  }

  String get formattedAmount {
    return '$formattedAmountWithoutDimension mmHg';
  }

  String get formattedAmountWithoutDimension {
    return '$systolicBloodPressure / $diastolicBloodPressure';
  }

  String formatAmountWithoutDimensionWithTime(BuildContext context) {
    final time = measuredAt.timeOfDayLocal.format(context);
    return '$formattedAmountWithoutDimension ($time)';
  }
}

extension PulseExtensions on Pulse {
  PulseRequestBuilder toRequestBuilder() {
    final builder = PulseRequestBuilder();

    builder.pulse = pulse;
    builder.measuredAt = measuredAt.toUtc();

    return builder;
  }

  String formattedAmount(AppLocalizations appLocalizations) {
    return '$pulse ${appLocalizations.pulseDimension}';
  }

  String formatAmountWithoutDimensionWithTime(BuildContext context) {
    final time = measuredAt.timeOfDayLocal.format(context);
    return '$pulse ($time)';
  }
}

// Health indicators
extension DailyHealthStatusExtensions on DailyHealthStatus {
  bool isIndicatorExists(HealthIndicator indicator) {
    switch (indicator) {
      case HealthIndicator.bloodPressure:
        return bloodPressures.isNotEmpty;
      case HealthIndicator.pulse:
        return pulses.isNotEmpty;
      case HealthIndicator.weight:
        return weightKg != null;
      case HealthIndicator.glucose:
        return glucose != null;
      case HealthIndicator.urine:
        return urineMl != null;
      case HealthIndicator.severityOfSwelling:
        return swellingDifficulty != null &&
            swellingDifficulty != SwellingDifficultyEnum.unknown;
      case HealthIndicator.swellings:
        return swellings
            .where((e) => e.swelling != SwellingEnum.unknown)
            .isNotEmpty;
      case HealthIndicator.wellBeing:
        return wellFeeling != null && wellFeeling != WellFeelingEnum.unknown;
      case HealthIndicator.appetite:
        return appetite != null && appetite != AppetiteEnum.unknown;
      case HealthIndicator.shortnessOfBreath:
        return shortnessOfBreath != null &&
            shortnessOfBreath != ShortnessOfBreathEnum.unknown;
    }
  }

  DailyHealthStatusRequest toRequest() {
    final builder = DailyHealthStatusRequestBuilder();

    builder.date = date;

    builder.weightKg = weightKg;
    builder.urineMl = urineMl;
    builder.glucose = glucose;

    builder.wellFeeling = wellFeeling;
    builder.shortnessOfBreath = shortnessOfBreath;
    builder.appetite = appetite;

    builder.swellingDifficulty = swellingDifficulty;

    final swellingRequests = swellings.map<SwellingRequest>((e) {
      final swellingBuilder = SwellingRequestBuilder();
      swellingBuilder.swelling = e.swelling;

      return swellingBuilder.build();
    }).toList();

    builder.swellings = ListBuilder(swellingRequests);

    return builder.build();
  }

  String? getHealthIndicatorFormatted(
    HealthIndicator indicator,
    AppLocalizations appLocalizations,
  ) {
    if (!isIndicatorExists(indicator)) {
      return null;
    }

    switch (indicator) {
      case HealthIndicator.bloodPressure:
        final latestBloodPressure = bloodPressures.maxBy((p) => p.measuredAt)!;
        return '${latestBloodPressure.systolicBloodPressure} / ${latestBloodPressure.diastolicBloodPressure} mmHg';
      case HealthIndicator.pulse:
        final latestPulse = pulses.maxBy((p) => p.measuredAt)!;
        return '${latestPulse.pulse} ${appLocalizations.pulseDimension}';
      case HealthIndicator.weight:
        return '$weightKg kg';
      case HealthIndicator.glucose:
        return '${glucose!.toStringAsFixed(2)} mmol/l';
      case HealthIndicator.urine:
        return _formatAmount(urineMl!, 'ml');
      case HealthIndicator.severityOfSwelling:
        switch (swellingDifficulty) {
          case SwellingDifficultyEnum.n0plus:
            return '0+';
          case SwellingDifficultyEnum.n1plus:
            return '1+';
          case SwellingDifficultyEnum.n2plus:
            return '2+';
          case SwellingDifficultyEnum.n3plus:
            return '3+';
          case SwellingDifficultyEnum.n4plus:
            return '4+';
          case SwellingDifficultyEnum.unknown:
            return null;
        }
        throw ArgumentError.value(
          swellingDifficulty,
          'swellingDifficulty',
          'Invalid swellingDifficulty value',
        );
      case HealthIndicator.swellings:
        return getHealthIndicatorValue(indicator)?.toString();
      case HealthIndicator.wellBeing:
        switch (wellFeeling) {
          case WellFeelingEnum.perfect:
            return appLocalizations.healthStatusCreationWellFeelingPerfect;
          case WellFeelingEnum.good:
            return appLocalizations.healthStatusCreationWellFeelingGood;
          case WellFeelingEnum.average:
            return appLocalizations.healthStatusCreationWellFeelingAverage;
          case WellFeelingEnum.bad:
            return appLocalizations.healthStatusCreationWellFeelingBad;
          case WellFeelingEnum.veryBad:
            return appLocalizations.healthStatusCreationWellFeelingVeryBad;
          case WellFeelingEnum.unknown:
            return null;
        }
        throw ArgumentError.value(
          wellFeeling,
          'wellFeeling',
          'Invalid wellFeeling value',
        );
      case HealthIndicator.appetite:
        switch (appetite) {
          case AppetiteEnum.perfect:
            return appLocalizations.healthStatusCreationAppetitePerfect;
          case AppetiteEnum.good:
            return appLocalizations.healthStatusCreationAppetiteGood;
          case AppetiteEnum.average:
            return appLocalizations.healthStatusCreationAppetiteAverage;
          case AppetiteEnum.bad:
            return appLocalizations.healthStatusCreationAppetiteVeryBad;
          case AppetiteEnum.veryBad:
            return appLocalizations.healthStatusCreationAppetiteVeryBad;
          case AppetiteEnum.unknown:
            return null;
        }
        throw ArgumentError.value(
          appetite,
          'appetite',
          'Invalid appetite value',
        );
      case HealthIndicator.shortnessOfBreath:
        switch (shortnessOfBreath) {
          case ShortnessOfBreathEnum.no:
            return appLocalizations.healthStatusCreationShortnessOfBreathNo;
          case ShortnessOfBreathEnum.light:
            return appLocalizations.healthStatusCreationShortnessOfBreathLight;
          case ShortnessOfBreathEnum.average:
            return appLocalizations
                .healthStatusCreationShortnessOfBreathAverage;
          case ShortnessOfBreathEnum.severe:
            return appLocalizations.healthStatusCreationShortnessOfBreathSevere;
          case ShortnessOfBreathEnum.backbreaking:
            return appLocalizations
                .healthStatusCreationShortnessOfBreathBackbreaking;
          case ShortnessOfBreathEnum.unknown:
            return null;
        }
        throw ArgumentError.value(
          shortnessOfBreath,
          'shortnessOfBreath',
          'Invalid shortnessOfBreath value',
        );
    }
  }

  Iterable<ManualPeritonealDialysis> get manualPeritonealDialysisReverseSorted {
    return manualPeritonealDialysis.orderBy((d) => d.startedAt, reverse: true);
  }

  num? getHealthIndicatorValue(HealthIndicator indicator) {
    if (!isIndicatorExists(indicator)) {
      return null;
    }

    switch (indicator) {
      case HealthIndicator.bloodPressure:
        throw ArgumentError(
            'Unable to get blood pressure indicator value. Please use different method');
      case HealthIndicator.pulse:
        return pulses.maxBy((p) => p.measuredAt)!.pulse;
      case HealthIndicator.weight:
        return weightKg;
      case HealthIndicator.glucose:
        return glucose;
      case HealthIndicator.urine:
        return urineMl;
      case HealthIndicator.severityOfSwelling:
        switch (swellingDifficulty) {
          case SwellingDifficultyEnum.n0plus:
            return 0;
          case SwellingDifficultyEnum.n1plus:
            return 1;
          case SwellingDifficultyEnum.n2plus:
            return 2;
          case SwellingDifficultyEnum.n3plus:
            return 3;
          case SwellingDifficultyEnum.n4plus:
            return 4;
          case SwellingDifficultyEnum.unknown:
            return null;
        }
        throw ArgumentError.value(
          swellingDifficulty,
          'swellingDifficulty',
          'Invalid swellingDifficulty value',
        );
      case HealthIndicator.swellings:
        return swellings
            .where((e) => e.swelling != SwellingEnum.unknown)
            .length;
      case HealthIndicator.wellBeing:
        switch (wellFeeling) {
          case WellFeelingEnum.perfect:
            return 1;
          case WellFeelingEnum.good:
            return 2;
          case WellFeelingEnum.average:
            return 3;
          case WellFeelingEnum.bad:
            return 4;
          case WellFeelingEnum.veryBad:
            return 5;
          case WellFeelingEnum.unknown:
            return null;
        }
        throw ArgumentError.value(
          wellFeeling,
          'wellFeeling',
          'Invalid wellFeeling value',
        );
      case HealthIndicator.appetite:
        switch (appetite) {
          case AppetiteEnum.perfect:
            return 1;
          case AppetiteEnum.good:
            return 2;
          case AppetiteEnum.average:
            return 3;
          case AppetiteEnum.bad:
            return 4;
          case AppetiteEnum.veryBad:
            return 5;
          case AppetiteEnum.unknown:
            return null;
        }
        throw ArgumentError.value(
          appetite,
          'appetite',
          'Invalid appetite value',
        );
      case HealthIndicator.shortnessOfBreath:
        switch (shortnessOfBreath) {
          case ShortnessOfBreathEnum.no:
            return 1;
          case ShortnessOfBreathEnum.light:
            return 2;
          case ShortnessOfBreathEnum.average:
            return 3;
          case ShortnessOfBreathEnum.severe:
            return 4;
          case ShortnessOfBreathEnum.backbreaking:
            return 5;
          case ShortnessOfBreathEnum.unknown:
            return null;
        }
        throw ArgumentError.value(
          shortnessOfBreath,
          'shortnessOfBreath',
          'Invalid shortnessOfBreath value',
        );
    }
  }

  int get totalManualPeritonealDialysisBalance =>
      manualPeritonealDialysis.sumBy((d) => d.balance).toInt();

  String get totalManualPeritonealDialysisBalanceFormatted =>
      _formatAmount(totalManualPeritonealDialysisBalance, 'ml');
}

extension HealthIndicatorExtensions on HealthIndicator {
  String name(AppLocalizations appLocalizations) {
    switch (this) {
      case HealthIndicator.bloodPressure:
        return appLocalizations.healthStatusCreationBloodPressure;
      case HealthIndicator.pulse:
        return appLocalizations.pulse;
      case HealthIndicator.weight:
        return appLocalizations.weight;
      case HealthIndicator.glucose:
        return appLocalizations.healthStatusCreationGlucose;
      case HealthIndicator.urine:
        return appLocalizations.healthStatusCreationUrine;
      case HealthIndicator.severityOfSwelling:
        return appLocalizations.healthStatusCreationSwellingDifficulty;
      case HealthIndicator.swellings:
        return appLocalizations.healthStatusCreationSwellings;
      case HealthIndicator.wellBeing:
        return appLocalizations.healthStatusCreationWellFeeling;
      case HealthIndicator.appetite:
        return appLocalizations.healthStatusCreationAppetite;
      case HealthIndicator.shortnessOfBreath:
        return appLocalizations.healthStatusCreationShortnessOfBreath;
    }
  }

  bool get isMultiValuesPerDay {
    switch (this) {
      case HealthIndicator.bloodPressure:
      case HealthIndicator.pulse:
        return true;
      case HealthIndicator.weight:
      case HealthIndicator.glucose:
      case HealthIndicator.urine:
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.swellings:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        return false;
    }
  }

  int get decimalPlaces {
    switch (this) {
      case HealthIndicator.bloodPressure:
      case HealthIndicator.pulse:
        return 0;
      case HealthIndicator.weight:
        return 1;
      case HealthIndicator.glucose:
        return 2;
      case HealthIndicator.urine:
        return 1;
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.swellings:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        return 1;
    }
  }

  String? dimension(AppLocalizations appLocalizations) {
    switch (this) {
      case HealthIndicator.bloodPressure:
        return 'mmHg';
      case HealthIndicator.pulse:
        return appLocalizations.pulseDimension;
      case HealthIndicator.weight:
        return 'kg';
      case HealthIndicator.glucose:
        return 'mmol/l';
      case HealthIndicator.urine:
        return 'ml';
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.swellings:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        return null;
    }
  }
}

extension DialysisSolutionExtension on DialysisSolutionEnum {
  String localizedName(AppLocalizations appLocalizations) {
    switch (this) {
      case DialysisSolutionEnum.green:
        return appLocalizations.dialysisSolutionGreen;
      case DialysisSolutionEnum.yellow:
        return appLocalizations.dialysisSolutionYellow;

      case DialysisSolutionEnum.orange:
        return appLocalizations.dialysisSolutionOrange;

      case DialysisSolutionEnum.blue:
        return appLocalizations.dialysisSolutionBlue;

      case DialysisSolutionEnum.purple:
        return appLocalizations.dialysisSolutionPurple;

      case DialysisSolutionEnum.unknown:
        return appLocalizations.unknown;
    }

    throw ArgumentError.value(this);
  }

  String localizedDescription(AppLocalizations appLocalizations) {
    switch (this) {
      case DialysisSolutionEnum.green:
        return appLocalizations.dialysisSolutionGreenDescription;
      case DialysisSolutionEnum.yellow:
        return appLocalizations.dialysisSolutionYellowDescription;

      case DialysisSolutionEnum.orange:
        return appLocalizations.dialysisSolutionOrangeDescription;

      case DialysisSolutionEnum.blue:
        return appLocalizations.dialysisSolutionBlueDescription;

      case DialysisSolutionEnum.purple:
        return appLocalizations.dialysisSolutionPurpleDescription;

      case DialysisSolutionEnum.unknown:
        return appLocalizations.unknown;
    }

    throw ArgumentError.value(this);
  }

  Color get color {
    switch (this) {
      case DialysisSolutionEnum.green:
        return Colors.green;
      case DialysisSolutionEnum.yellow:
        return Colors.yellow;
      case DialysisSolutionEnum.orange:
        return Colors.orange;
      case DialysisSolutionEnum.blue:
        return Colors.blue;
      case DialysisSolutionEnum.purple:
        return Colors.purple;
      case DialysisSolutionEnum.unknown:
        return Colors.black;
    }

    throw ArgumentError.value(this);
  }

  Color get textColor {
    switch (this) {
      case DialysisSolutionEnum.yellow:
        return Colors.black;
      case DialysisSolutionEnum.green:
      case DialysisSolutionEnum.orange:
      case DialysisSolutionEnum.blue:
      case DialysisSolutionEnum.purple:
      case DialysisSolutionEnum.unknown:
        return Colors.white;
    }

    throw ArgumentError.value(this);
  }
}

extension DialysateColorExtensions on DialysateColorEnum {
  String localizedName(AppLocalizations appLocalizations) {
    switch (this) {
      case DialysateColorEnum.transparent:
        return appLocalizations.dialysateColorTransparent;
      case DialysateColorEnum.pink:
        return appLocalizations.dialysateColorPink;

      case DialysateColorEnum.cloudyYellowish:
        return appLocalizations.dialysateColorCloudyYellowish;

      case DialysateColorEnum.greenish:
        return appLocalizations.dialysateColorGreenish;

      case DialysateColorEnum.brown:
        return appLocalizations.dialysateColorBrown;

      case DialysateColorEnum.cloudyWhite:
        return appLocalizations.dialysateColorCloudyWhite;

      case DialysateColorEnum.unknown:
        return appLocalizations.unknown;
    }

    throw ArgumentError.value(this);
  }

  Color get color {
    switch (this) {
      case DialysateColorEnum.transparent:
        return Colors.transparent;
      case DialysateColorEnum.pink:
        return Colors.pink;
      case DialysateColorEnum.cloudyYellowish:
        return Colors.yellowAccent;
      case DialysateColorEnum.greenish:
        return Colors.lightGreen;
      case DialysateColorEnum.brown:
        return Colors.brown;
      case DialysateColorEnum.cloudyWhite:
        return Colors.grey;
      case DialysateColorEnum.unknown:
        return Colors.black;
    }

    throw ArgumentError.value(this);
  }

  Color get textColor {
    switch (this) {
      case DialysateColorEnum.transparent:
      case DialysateColorEnum.cloudyWhite:
      case DialysateColorEnum.cloudyYellowish:
        return Colors.black;
      case DialysateColorEnum.pink:
      case DialysateColorEnum.greenish:
      case DialysateColorEnum.brown:
      case DialysateColorEnum.unknown:
        return Colors.white;
    }

    throw ArgumentError.value(this);
  }
}

extension ManualPeritonealDialysisExtensions on ManualPeritonealDialysis {
  int get balance => solutionOutMl != null ? solutionInMl - solutionOutMl! : 0;

  ManualPeritonealDialysisRequestBuilder toRequestBuilder() {
    final builder = ManualPeritonealDialysisRequestBuilder();

    builder.isCompleted = isCompleted;
    builder.startedAt = startedAt;
    builder.dialysisSolution = dialysisSolution;
    builder.solutionInMl = solutionInMl;
    builder.solutionOutMl = solutionOutMl;
    builder.dialysateColor = dialysateColor;
    builder.notes = notes;

    return builder;
  }

  bool get hasValidDuration {
    if (isCompleted! && finishedAt == null) {
      return false;
    }

    return true;
  }

  Duration get duration {
    final finish = finishedAt ?? DateTime.now();

    return finish.toUtc().difference(startedAt.toUtc());
  }

  String get formattedBalance {
    return _formatAmount(balance, 'ml');
  }

  String get formattedSolutionIn {
    return _formatAmount(solutionInMl, 'ml');
  }

  String get formattedSolutionOut {
    if (solutionOutMl == null) {
      return '-';
    }
    return _formatAmount(solutionOutMl!, 'ml');
  }
}

extension AutomaticPeritonealDialysisExtensions on AutomaticPeritonealDialysis {
  AutomaticPeritonealDialysisRequestBuilder toRequestBuilder() {
    final builder = AutomaticPeritonealDialysisRequestBuilder();

    builder.isCompleted = isCompleted;
    builder.startedAt = startedAt;

    builder.solutionBlueInMl = solutionBlueInMl;
    builder.solutionGreenInMl = solutionGreenInMl;
    builder.solutionOrangeInMl = solutionOrangeInMl;
    builder.solutionPurpleInMl = solutionPurpleInMl;
    builder.solutionYellowInMl = solutionYellowInMl;

    builder.initialDrainingMl = initialDrainingMl;
    builder.totalDrainVolumeMl = totalDrainVolumeMl;
    builder.lastFillMl = lastFillMl;
    builder.totalUltrafiltrationMl = totalUltrafiltrationMl;

    builder.dialysateColor = dialysateColor;

    builder.notes = notes;
    builder.finishedAt = finishedAt;

    return builder;
  }

  int get balance {
    if (totalUltrafiltrationMl == null) {
      return 0;
    }

    final totalLiquidsMl =
        dailyIntakesLightReport.nutrientNormsAndTotals.liquidsMl.total;
    final totalUrineMl = dailyHealthStatus.urineMl ?? 0;

    return totalLiquidsMl - totalUltrafiltrationMl! - totalUrineMl;
  }

  String get formattedBalance {
    return _formatAmount(balance, 'ml');
  }

  Iterable<DialysisSolutionEnum> getSolutionsUsed() {
    return DialysisSolutionEnum.values.where((s) => hasVolume(s));
  }

  int? getSolutionVolumeInMl(DialysisSolutionEnum solution) {
    switch (solution) {
      case DialysisSolutionEnum.purple:
        return solutionPurpleInMl;
      case DialysisSolutionEnum.yellow:
        return solutionYellowInMl;
      case DialysisSolutionEnum.orange:
        return solutionOrangeInMl;
      case DialysisSolutionEnum.green:
        return solutionGreenInMl;
      case DialysisSolutionEnum.blue:
        return solutionBlueInMl;
      case DialysisSolutionEnum.unknown:
        return 0;
    }

    throw ArgumentError.value(solution);
  }

  bool hasVolume(DialysisSolutionEnum solution) {
    return getSolutionVolumeInMl(solution) != 0;
  }

  String getSolutionVolumeFormatted(DialysisSolutionEnum solution) {
    final volume = getSolutionVolumeInMl(solution) ?? 0;

    return _formatAmount(volume, 'ml');
  }

  bool get isDialysateColorNonRegular {
    return dialysateColor != DialysateColorEnum.transparent &&
        dialysateColor != DialysateColorEnum.unknown;
  }
}

extension UserProfileExtensions on UserProfileV2 {
  UserProfileV2RequestBuilder toRequestBuilder() {
    final builder = UserProfileV2RequestBuilder();

    builder.gender = gender;
    builder.heightCm = heightCm;
    builder.chronicKidneyDiseaseAge = chronicKidneyDiseaseAge;
    builder.chronicKidneyDiseaseStage = chronicKidneyDiseaseStage;

    builder.dialysis = dialysis;

    builder.diabetesType = diabetesType;

    return builder;
  }
}

extension ChronicKidneyDiseaseStageEnumExtensions
    on ChronicKidneyDiseaseStageEnum {
  String title(AppLocalizations appLocalizations) {
    switch (this) {
      case ChronicKidneyDiseaseStageEnum.stage1:
        return '1 ${appLocalizations.stage}';
      case ChronicKidneyDiseaseStageEnum.stage2:
        return '2 ${appLocalizations.stage}';
      case ChronicKidneyDiseaseStageEnum.stage3:
        return '3 ${appLocalizations.stage}';
      case ChronicKidneyDiseaseStageEnum.stage4:
        return '4 ${appLocalizations.stage}';
      case ChronicKidneyDiseaseStageEnum.stage5:
        return '5 ${appLocalizations.stage}';
      case ChronicKidneyDiseaseStageEnum.unknown:
        return appLocalizations.iDontKnown;
    }
    throw ArgumentError.value(this, 'ChronicKidneyDiseaseStageEnum');
  }

  String? description(AppLocalizations appLocalizations) {
    switch (this) {
      case ChronicKidneyDiseaseStageEnum.stage1:
        return appLocalizations.chronicKidneyDiseaseStage1Description;
      case ChronicKidneyDiseaseStageEnum.stage2:
        return appLocalizations.chronicKidneyDiseaseStage2Description;
      case ChronicKidneyDiseaseStageEnum.stage3:
        return appLocalizations.chronicKidneyDiseaseStage3Description;
      case ChronicKidneyDiseaseStageEnum.stage4:
        return appLocalizations.chronicKidneyDiseaseStage4Description;
      case ChronicKidneyDiseaseStageEnum.stage5:
        return appLocalizations.chronicKidneyDiseaseStage5Description;
      case ChronicKidneyDiseaseStageEnum.unknown:
        return null;
    }
    throw ArgumentError.value(this, 'ChronicKidneyDiseaseStageEnum');
  }
}

extension DialysisTypeExtension on DialysisEnum {
  String title(AppLocalizations appLocalizations) {
    switch (this) {
      case DialysisEnum.manualPeritonealDialysis:
        return appLocalizations.peritonealDialysisTypeManual;
      case DialysisEnum.automaticPeritonealDialysis:
        return appLocalizations.peritonealDialysisTypeAutomatic;
      case DialysisEnum.hemodialysis:
        return appLocalizations.userProfileSectionDialysisTypeHemodialysis;
      case DialysisEnum.notPerformed:
        return appLocalizations.userProfileSectionDialysisTypeNotPerformed;
      case DialysisEnum.postTransplant:
        return appLocalizations.userProfileSectionDialysisTypePostTransplant;
      case DialysisEnum.unknown:
        return appLocalizations.iDontKnown;
    }
    throw ArgumentError.value(this, 'ChronicKidneyDiseaseStageEnum');
  }

  String? description(AppLocalizations appLocalizations) {
    switch (this) {
      case DialysisEnum.postTransplant:
        return appLocalizations
            .userProfileSectionDialysisTypePostTransplantDescription;
      case DialysisEnum.manualPeritonealDialysis:
        return appLocalizations.peritonealDialysisTypeManualAlternative;
      default:
        return null;
    }
  }
}

extension ChronicKidneyDiseaseAgeEnumExtensions on ChronicKidneyDiseaseAgeEnum {
  String title(AppLocalizations appLocalizations) {
    switch (this) {
      case ChronicKidneyDiseaseAgeEnum.lessThan1:
        return appLocalizations.chronicKidneyDiseaseAgeNoMoreThanYear;
      case ChronicKidneyDiseaseAgeEnum.n15:
        return appLocalizations.chronicKidneyDiseaseAge1To5Years;
      case ChronicKidneyDiseaseAgeEnum.n610:
        return appLocalizations.chronicKidneyDiseaseAge6To10Years;
      case ChronicKidneyDiseaseAgeEnum.greaterThan10:
        return appLocalizations.chronicKidneyDiseaseMoreThan10Years;
      case ChronicKidneyDiseaseAgeEnum.unknown:
        return appLocalizations.iDontKnown;
    }
    throw ArgumentError.value(this, 'ChronicKidneyDiseaseAgeEnum');
  }
}

extension EnumClassExtensions<E extends EnumClass> on E {
  E? enumWithoutDefault(E defaultValue) => (this == defaultValue) ? null : this;
}
