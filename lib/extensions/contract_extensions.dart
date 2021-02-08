import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo_api_client/model/appetite_enum.dart';
import 'package:nephrogo_api_client/model/daily_health_status.dart';
import 'package:nephrogo_api_client/model/daily_nutrient_consumption.dart';
import 'package:nephrogo_api_client/model/daily_nutrient_norms_with_totals.dart';
import 'package:nephrogo_api_client/model/intake.dart';
import 'package:nephrogo_api_client/model/product.dart';
import 'package:nephrogo_api_client/model/shortness_of_breath_enum.dart';
import 'package:nephrogo_api_client/model/swelling.dart';
import 'package:nephrogo_api_client/model/swelling_difficulty_enum.dart';
import 'package:nephrogo_api_client/model/swelling_enum.dart';
import 'package:nephrogo_api_client/model/well_feeling_enum.dart';

String _formatAmount<T extends num>(T amount, String dim) {
  var precision = 0;
  if (amount is double && amount < 1000) {
    precision = 2;
  }

  return '${amount.toStringAsFixed(precision)} $dim';
}

String _getFormattedNutrient(Nutrient nutrient, int amount) {
  switch (nutrient) {
    case Nutrient.energy:
      return _formatAmount(amount, 'kcal');
    case Nutrient.liquids:
      return _formatAmount(amount, 'g');
    case Nutrient.proteins:
    case Nutrient.sodium:
    case Nutrient.potassium:
    case Nutrient.phosphorus:
      return _formatAmount(amount / 1000, 'g');
    default:
      throw ArgumentError.value(
          nutrient, 'nutrient', 'Unable to map nutrient to amount');
  }
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
        return liquidsG;
      case Nutrient.energy:
        return energyKcal;
      default:
        throw ArgumentError.value(
            nutrient, 'nutrient', 'Unable to map indicator to amount');
    }
  }

  int _calculateTotalNutrientAmount(Nutrient nutrient, int amountG) {
    final nutrientAmount = _getNutrientAmount(nutrient);
    final nutrientAmountRatio = amountG / 100;

    return (nutrientAmount * nutrientAmountRatio).round();
  }

  String getFormattedTotalAmount(Nutrient nutrient, int amountG) {
    return _getFormattedNutrient(
        nutrient, _calculateTotalNutrientAmount(nutrient, amountG));
  }

  int getNutrientNormPercentage(Nutrient nutrient, int amountG, int norm) {
    return ((_calculateTotalNutrientAmount(nutrient, amountG) / norm) * 100)
        .round();
  }

  // This is used for generating intakes required to show nutrient amounts
  // after searching for a product
  Intake fakeIntake({
    @required int amountG,
    @required int amountMl,
    @required DateTime consumedAt,
  }) {
    final builder = IntakeBuilder();

    builder.consumedAt = consumedAt;

    builder.amountG = amountG;
    builder.amountMl = amountMl;

    builder.potassiumMg =
        _calculateTotalNutrientAmount(Nutrient.potassium, amountG);
    builder.proteinsMg =
        _calculateTotalNutrientAmount(Nutrient.proteins, amountG);
    builder.sodiumMg = _calculateTotalNutrientAmount(Nutrient.sodium, amountG);
    builder.phosphorusMg =
        _calculateTotalNutrientAmount(Nutrient.phosphorus, amountG);
    builder.energyKcal =
        _calculateTotalNutrientAmount(Nutrient.energy, amountG);
    builder.liquidsG = _calculateTotalNutrientAmount(Nutrient.liquids, amountG);

    builder.product = toBuilder();

    return builder.build();
  }
}

extension DailyNutrientConsumptionExtensions on DailyNutrientConsumption {
  int totalConsumptionRoundedPercentage() {
    if (norm == null) {
      return null;
    }

    return ((total / norm) * 100).round();
  }

  int normPercentage(int nutrientAmount) {
    if (norm == null) {
      return null;
    }

    return ((nutrientAmount / norm) * 100).round();
  }

  bool get isNormExceeded {
    if (norm == null) {
      return null;
    }

    return total > norm;
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
        return liquidsG;
      case Nutrient.energy:
        return energyKcal;
      default:
        throw ArgumentError.value(
            nutrient, 'nutrient', 'Unable to map indicator to amount');
    }
  }

  String getNutrientTotalAmountFormatted(Nutrient nutrient) {
    final amount = getDailyNutrientConsumption(nutrient).total;
    assert(amount != null);

    return _getFormattedNutrient(nutrient, amount);
  }

  String getNutrientNormFormatted(Nutrient nutrient) {
    final norm = getDailyNutrientConsumption(nutrient).norm;
    if (norm == null) {
      return null;
    }

    return _getFormattedNutrient(nutrient, norm);
  }

  int getRoundedNormPercentage(Nutrient nutrient) {
    final consumption = getDailyNutrientConsumption(nutrient);

    if (consumption.norm == null) {
      return null;
    }

    return ((consumption.total / consumption.norm) * 100).round();
  }

  int normsExceededCount() {
    return Nutrient.values
        .map(getDailyNutrientConsumption)
        .where((c) => c.isNormExceeded == true)
        .length;
  }

  bool isAtLeastOneNormExceeded() {
    return Nutrient.values
        .map(getDailyNutrientConsumption)
        .any((c) => c.isNormExceeded == true);
  }
}

extension IntakeExtension on Intake {
  int getNutrientAmount(Nutrient nutrient) {
    switch (nutrient) {
      case Nutrient.energy:
        return energyKcal;
      case Nutrient.liquids:
        return liquidsG;
      case Nutrient.proteins:
        return proteinsMg;
      case Nutrient.sodium:
        return sodiumMg;
      case Nutrient.potassium:
        return potassiumMg;
      case Nutrient.phosphorus:
        return phosphorusMg;
      default:
        throw ArgumentError.value(
            nutrient, 'nutrient', 'Unable to map indicator to amount');
    }
  }

  String getNutrientAmountFormatted(Nutrient nutrient) {
    final amount = getNutrientAmount(nutrient);

    return _getFormattedNutrient(nutrient, amount);
  }

  String getAmountFormatted() {
    if (amountMl != null) {
      return _formatAmount(amountMl, 'ml');
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
      default:
        throw ArgumentError.value(
            this, 'nutrient', 'Unable to map nutrient to name');
    }
  }
}

extension SwellingExtension on Swelling {
  String getLocalizedName(AppLocalizations appLocalizations) {
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
      default:
        throw ArgumentError.value(
          swelling,
          'swelling',
          'Invalid swelling value',
        );
    }
  }
}

// Health indicators
extension DailyHealthStatusExtensions on DailyHealthStatus {
  bool isIndicatorExists(HealthIndicator indicator) {
    switch (indicator) {
      case HealthIndicator.bloodPressure:
        return diastolicBloodPressure != null && systolicBloodPressure != null;
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
        return swellings != null &&
            swellings
                .where((e) => e.swelling != SwellingEnum.unknown)
                .isNotEmpty;
      case HealthIndicator.wellBeing:
        return wellFeeling != null && wellFeeling != WellFeelingEnum.unknown;
      case HealthIndicator.appetite:
        return appetite != null && appetite != AppetiteEnum.unknown;
      case HealthIndicator.shortnessOfBreath:
        return shortnessOfBreath != null &&
            shortnessOfBreath != ShortnessOfBreathEnum.unknown;
      default:
        throw ArgumentError.value(
          this,
          'healthIndicator',
          'Unable to map indicator and check for indicator existance',
        );
    }
  }

  String getHealthIndicatorFormatted(
      HealthIndicator indicator, AppLocalizations appLocalizations) {
    if (!isIndicatorExists(indicator)) {
      return null;
    }

    switch (indicator) {
      case HealthIndicator.bloodPressure:
        return '$systolicBloodPressure / $diastolicBloodPressure mmHg';
      case HealthIndicator.weight:
        return '$weightKg kg';
      case HealthIndicator.glucose:
        return '${glucose.toStringAsFixed(2)} mmol/l';
      case HealthIndicator.urine:
        return _formatAmount(urineMl, 'ml');
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
      default:
        throw ArgumentError.value(
          this,
          'healthIndicator',
          'Unable to map indicator to formatted indicator',
        );
    }
  }

  num getHealthIndicatorValue(HealthIndicator indicator) {
    if (!isIndicatorExists(indicator)) {
      return null;
    }

    switch (indicator) {
      case HealthIndicator.bloodPressure:
        return systolicBloodPressure;
      case HealthIndicator.weight:
        return weightKg;
      case HealthIndicator.glucose:
        return glucose;
      case HealthIndicator.urine:
        return urineMl;
      case HealthIndicator.severityOfSwelling:
        switch (swellingDifficulty) {
          case SwellingDifficultyEnum.n0plus:
            return 1;
          case SwellingDifficultyEnum.n1plus:
            return 2;
          case SwellingDifficultyEnum.n2plus:
            return 3;
          case SwellingDifficultyEnum.n3plus:
            return 4;
          case SwellingDifficultyEnum.n4plus:
            return 5;
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
      default:
        throw ArgumentError.value(
          this,
          'healthIndicator',
          'Unable to map indicator to formatted indicator',
        );
    }
  }
}

extension HealthIndicatorExtensions on HealthIndicator {
  String name(AppLocalizations appLocalizations) {
    switch (this) {
      case HealthIndicator.bloodPressure:
        return appLocalizations.healthStatusCreationBloodPressure;
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
      default:
        throw ArgumentError.value(
          this,
          'healthIndicator',
          'Unable to map indicator to name',
        );
    }
  }
}

extension EnumClassExtensions<E extends EnumClass> on E {
  E enumWithoutDefault(E defaultValue) => (this == defaultValue) ? null : this;
}
