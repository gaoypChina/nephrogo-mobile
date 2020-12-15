import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'collection_extensions.dart';

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

extension DailyIntakesExtensions on DailyIntake {
  int get totalPotassiumMg => intakes.map((e) => e.potassiumMg).sum;

  int get totalProteinsMg => intakes.map((e) => e.proteinsMg).sum;

  int get totalSodiumMg => intakes.map((e) => e.sodiumMg).sum;

  int get totalPhosphorusMg => intakes.map((e) => e.phosphorusMg).sum;

  int get totalEnergyKC => intakes.map((e) => e.energyKC).sum;

  int get totalLiquidsMl => intakes.map((e) => e.liquidsMl).sum;

  int getNutrientTotalAmount(Nutrient nutrient) {
    if (this.intakes.isEmpty) {
      return 0;
    }

    switch (nutrient) {
      case Nutrient.energy:
        return this.totalEnergyKC;
      case Nutrient.liquids:
        return this.totalLiquidsMl;
      case Nutrient.proteins:
        return this.totalProteinsMg;
      case Nutrient.sodium:
        return this.totalSodiumMg;
      case Nutrient.potassium:
        return this.totalPotassiumMg;
      case Nutrient.phosphorus:
        return this.totalPhosphorusMg;
      default:
        throw ArgumentError.value(
            nutrient, "nutrient", "Unable to map indicator to total amount");
    }
  }

  double getNutrientConsumptionRatio(Nutrient nutrient) {
    if (this.intakes.isEmpty) {
      return 0;
    }

    final consumption =
        this.intakes.map((e) => e.getNutrientAmount(nutrient)).sum;
    final recommendation = this.userIntakeNorms.getNutrientAmount(nutrient);

    return consumption.toDouble() / recommendation;
  }

  String getNutrientTotalAmountFormatted(Nutrient nutrient) {
    final amount = getNutrientTotalAmount(nutrient);

    return _getFormattedNutrient(nutrient, amount);
  }
}

extension IntakeExtension on Intake {
  int getNutrientAmount(Nutrient nutrient) {
    switch (nutrient) {
      case Nutrient.energy:
        return this.energyKC;
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

extension DailyIntakeNormsExtensions on DailyIntakeNorms {
  int getNutrientAmount(Nutrient nutrient) {
    switch (nutrient) {
      case Nutrient.energy:
        return this.energyKC;
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
}

extension NutrientExtensions on Nutrient {
  String get name {
    switch (this) {
      case Nutrient.energy:
        return "Energija";
      case Nutrient.liquids:
        return "Skysčiai";
      case Nutrient.proteins:
        return "Baltymai";
      case Nutrient.sodium:
        return "Natris";
      case Nutrient.potassium:
        return "Kalis";
      case Nutrient.phosphorus:
        return "Fosforas";
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
        return weight != null;
      case HealthIndicator.urine:
        return urineMl != null;
      case HealthIndicator.severityOfSwelling:
        return severityOfSwelling != null;
      case HealthIndicator.numberOfSwellings:
        return numberOfSwellings != null;
      case HealthIndicator.wellBeing:
        return wellBeing != null;
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
        return "$weight kg";
      case HealthIndicator.urine:
        return _formatAmount(urineMl, "ml", "l");
      case HealthIndicator.severityOfSwelling:
        switch (severityOfSwelling) {
          case 1:
            return "0+";
          case 2:
            return "1+";
          case 3:
            return "2+";
          case 4:
            return "3+";
          case 5:
            return "4+";
        }
        throw ArgumentError.value(
          severityOfSwelling,
          "severityOfSwelling",
          "Invalid severityOfSwelling value",
        );
      case HealthIndicator.numberOfSwellings:
        return numberOfSwellings.toString();
      case HealthIndicator.wellBeing:
        switch (wellBeing) {
          case 1:
            return "Labai bloga";
          case 2:
            return "Bloga";
          case 3:
            return "Vidutinė";
          case 4:
            return "Gera";
          case 5:
            return "Puiki";
        }
        throw ArgumentError.value(
          wellBeing,
          "wellBeing",
          "Invalid wellBeing value",
        );
      case HealthIndicator.appetite:
        switch (appetite) {
          case 1:
            return "Labai blogas";
          case 2:
            return "Blogas";
          case 3:
            return "Vidutinis";
          case 4:
            return "Geras";
          case 5:
            return "Puikus";
        }
        throw ArgumentError.value(
          appetite,
          "appetite",
          "Invalid wellBeing value",
        );
      case HealthIndicator.shortnessOfBreath:
        switch (shortnessOfBreath) {
          case 1:
            return "Nėra";
          case 2:
            return "Lengvas";
          case 3:
            return "Vidutinis";
          case 4:
            return "Sunkus";
          case 5:
            return "Labai sunkus";
        }
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
        return this.weight.toDouble();
      case HealthIndicator.urine:
        return this.urineMl.toDouble();
      case HealthIndicator.severityOfSwelling:
        return this.severityOfSwelling.toDouble();
      case HealthIndicator.numberOfSwellings:
        return this.numberOfSwellings.toDouble();
      case HealthIndicator.wellBeing:
        return this.wellBeing.toDouble();
      case HealthIndicator.appetite:
        return this.appetite.toDouble();
      case HealthIndicator.shortnessOfBreath:
        return this.shortnessOfBreath.toDouble();
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
