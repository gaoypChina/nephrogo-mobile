import 'package:built_value/built_value.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog_api_client/model/daily_health_status.dart';
import 'package:nephrolog_api_client/model/daily_intake_report.dart';
import 'package:nephrolog_api_client/model/daily_nutrient_consumption.dart';
import 'package:nephrolog_api_client/model/intake.dart';

String _formatAmount(int amount, String baseDim, String kDim) {
  if (kDim != null && amount > 1000) {
    final fractionDigits = amount > 10000 ? 1 : 2;

    final formatter = NumberFormat.currency(
      decimalDigits: fractionDigits,
      symbol: kDim,
    );

    return formatter.format(amount / 1000);
  }

  return NumberFormat.currency(decimalDigits: 0, symbol: baseDim)
      .format(amount);
}

String _getFormattedNutrient(Nutrient nutrient, int amount) {
  switch (nutrient) {
    case Nutrient.energy:
      return _formatAmount(amount, "kcal", null);
    case Nutrient.liquids:
      return _formatAmount(amount, "ml", "l");
    case Nutrient.proteins:
    case Nutrient.sodium:
    case Nutrient.potassium:
    case Nutrient.phosphorus:
      return _formatAmount(amount, "mg", "g");
    default:
      throw ArgumentError.value(
          nutrient, "nutrient", "Unable to map nutrient to amount");
  }
}

extension DailyIntakesExtensions on DailyIntakeReport {
  DailyNutrientConsumption getNutrientConsumption(Nutrient nutrient) {
    switch (nutrient) {
      case Nutrient.energy:
        return this.energyKcal;
      case Nutrient.liquids:
        return this.liquidsMl;
      case Nutrient.proteins:
        return this.proteinsMg;
      case Nutrient.sodium:
        return this.sodiumMg;
      case Nutrient.potassium:
        return this.potassiumMg;
      case Nutrient.phosphorus:
        return this.phosphorusMg;
      default:
        throw ArgumentError.value(
            nutrient, "nutrient", "Unable to map indicator to total amount");
    }
  }

  int getNutrientTotalAmount(Nutrient nutrient) {
    return getNutrientConsumption(nutrient).total;
  }

  double getNutrientConsumptionRatio(Nutrient nutrient) {
    throw UnimplementedError();
  }

  String getNutrientTotalAmountFormatted(Nutrient nutrient) {
    final amount = getNutrientTotalAmount(nutrient);
    assert(amount != null);

    return _getFormattedNutrient(nutrient, amount);
  }
}

extension IntakeExtension on Intake {
  int getNutrientAmount(Nutrient nutrient) {
    switch (nutrient) {
      case Nutrient.energy:
        return this.energyKcal;
      case Nutrient.liquids:
        return this.liquidsMl;
      case Nutrient.proteins:
        return this.proteinsMg;
      case Nutrient.sodium:
        return this.sodiumMg;
      case Nutrient.potassium:
        return this.potassiumMg;
      case Nutrient.phosphorus:
        return this.phosphorusMg;
      default:
        throw ArgumentError.value(
            nutrient, "nutrient", "Unable to map indicator to amount");
    }
  }

  String getNutrientAmountFormatted(Nutrient nutrient) {
    final amount = getNutrientAmount(nutrient);

    return _getFormattedNutrient(nutrient, amount);
  }

  String getAmountFormatted() {
    return _formatAmount(this.amountG, "g", "kg");
  }
}

extension DailyNutrientConsumptionExtensions on DailyNutrientConsumption {
  // int getNutrientAmount(Nutrient nutrient) {
  //   switch (nutrient) {
  //     case Nutrient.energy:
  //       return this.energyKcal;
  //     case Nutrient.liquids:
  //       return this.liquidsMl;
  //     case Nutrient.proteins:
  //       return this.proteinsMg;
  //     case Nutrient.sodium:
  //       return this.sodiumMg;
  //     case Nutrient.potassium:
  //       return this.potassiumMg;
  //     case Nutrient.phosphorus:
  //       return this.phosphorusMg;
  //     default:
  //       throw ArgumentError.value(
  //           nutrient, "nutrient", "Unable to map indicator to amount");
  //   }
  // }

  // String getNutrientAmountFormatted(Nutrient nutrient) {
  //   final amount = getNutrientAmount(nutrient);
  //
  //   if (amount == null) {
  //     return null;
  //   }
  //
  //   return _getFormattedNutrient(nutrient, amount);
  // }
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
            this, "nutrient", "Unable to map nutrient to name");
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
      case HealthIndicator.urine:
        return urineMl != null;
      case HealthIndicator.severityOfSwelling:
        return swellingDifficulty != null;
      case HealthIndicator.numberOfSwellings:
        // TODO numberOfSwellings implementation
        return false;
      case HealthIndicator.wellBeing:
        return wellFeeling != null;
      case HealthIndicator.appetite:
        return appetite != null;
      case HealthIndicator.shortnessOfBreath:
        return shortnessOfBreath != null;
      default:
        throw ArgumentError.value(
          this,
          "healthIndicator",
          "Unable to map indicator and check for indicator existance",
        );
    }
  }

  String getHealthIndicatorFormatted(HealthIndicator indicator) {
    if (!isIndicatorExists(indicator)) {
      return null;
    }

    switch (indicator) {
      case HealthIndicator.bloodPressure:
        return "$diastolicBloodPressure / $systolicBloodPressure mmHg";
      case HealthIndicator.weight:
        return "$weightKg kg";
      case HealthIndicator.urine:
        return _formatAmount(urineMl, "ml", "l");
      case HealthIndicator.severityOfSwelling:
        // TODO generate
        switch (swellingDifficulty) {
        }
        throw ArgumentError.value(
          swellingDifficulty,
          "swellingDifficulty",
          "Invalid swellingDifficulty value",
        );
      case HealthIndicator.numberOfSwellings:
        // TODO missing from API
        return null;
      case HealthIndicator.wellBeing:
        // TODO generate
        switch (wellFeeling) {
          // case 1:
          //   return "Labai bloga";
          // case 2:
          //   return "Bloga";
          // case 3:
          //   return "Vidutinė";
          // case 4:
          //   return "Gera";
          // case 5:
          //   return "Puiki";
          // default:
          //   return "TODO";
        }
        throw ArgumentError.value(
          wellFeeling,
          "wellFeeling",
          "Invalid wellFeeling value",
        );
        // case HealthIndicator.appetite:
        //   switch (appetite) {
        //     case 1:
        //       return "Labai blogas";
        //     case 2:
        //       return "Blogas";
        //     case 3:
        //       return "Vidutinis";
        //     case 4:
        //       return "Geras";
        //     case 5:
        //       return "Puikus";
        //     default:
        //       return "TODO";
        //   }
        //   throw ArgumentError.value(
        //     appetite,
        //     "appetite",
        //     "Invalid wellBeing value",
        //   );
        // case HealthIndicator.shortnessOfBreath:
        //   switch (shortnessOfBreath) {
        //     case 1:
        //       return "Nėra";
        //     case 2:
        //       return "Lengvas";
        //     case 3:
        //       return "Vidutinis";
        //     case 4:
        //       return "Sunkus";
        //     case 5:
        //       return "Labai sunkus";
        //     default:
        //       return "TODO";
        //   }
        throw ArgumentError.value(
          shortnessOfBreath,
          "shortnessOfBreath",
          "Invalid shortnessOfBreath value",
        );
      default:
        throw ArgumentError.value(
          this,
          "healthIndicator",
          "Unable to map indicator to formatted indicator",
        );
    }
  }

  double getHealthIndicatorValue(HealthIndicator indicator) {
    if (!isIndicatorExists(indicator)) {
      return null;
    }

    switch (indicator) {
      case HealthIndicator.bloodPressure:
        return this.systolicBloodPressure.toDouble();
      case HealthIndicator.weight:
        return this.weightKg.toDouble();
      case HealthIndicator.urine:
        return this.urineMl.toDouble();
      case HealthIndicator.severityOfSwelling:
      // TODO correct mapping
      //   return this.severityOfSwelling.toDouble();
      // case HealthIndicator.numberOfSwellings:
      //   return this.numberOfSwellings.toDouble();
      // case HealthIndicator.wellBeing:
      //   return this.wellBeing.toDouble();
      // case HealthIndicator.appetite:
      //   return this.appetite.toDouble();
      // case HealthIndicator.shortnessOfBreath:
      //   return this.shortnessOfBreath.toDouble();
      default:
        throw ArgumentError.value(
          this,
          "healthIndicator",
          "Unable to map indicator to formatted indicator",
        );
    }
  }
}

extension HealthIndicatorExtensions on HealthIndicator {
  String get name {
    switch (this) {
    // TODO translations
      case HealthIndicator.bloodPressure:
        return "Kraujo spaudimas";
      case HealthIndicator.weight:
        return "Svoris";
      case HealthIndicator.urine:
        return "Šlapimo kiekis";
      case HealthIndicator.severityOfSwelling:
        return "Patinimų sunkumas";
      case HealthIndicator.numberOfSwellings:
        return "Patinimų kiekis";
      case HealthIndicator.wellBeing:
        return "Savijauta";
      case HealthIndicator.appetite:
        return "Apetitas";
      case HealthIndicator.shortnessOfBreath:
        return "Dusulys";
      default:
        throw ArgumentError.value(
          this,
          "healthIndicator",
          "Unable to map indicator to name",
        );
    }
  }
}

extension EnumClassExtensions<E extends EnumClass> on E {
  E enumWithoutDefault(E defaultValue) => (this == defaultValue) ? null : this;
}
