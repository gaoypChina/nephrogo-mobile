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
            this, "type", "Unable to map indicator to name");
    }
  }
}
