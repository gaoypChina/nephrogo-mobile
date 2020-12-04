import 'package:nephrolog/models/contract.dart';
import 'CollectionExtensions.dart';

String _formatAmount(int amount, String baseDim, String kDim) {
  if (kDim == null || amount < 200) {
    return "$amount $baseDim";
  }
  return "${(amount / 1000).toStringAsFixed(1)} $kDim";
}

extension DailyIntakesExtensions on DailyIntakes {
  int get totalPotassiumMg => intakes.map((e) => e.potassiumMg).sum;

  int get totalProteinsMg => intakes.map((e) => e.proteinsMg).sum;

  int get totalSodiumMg => intakes.map((e) => e.sodiumMg).sum;

  int get totalPhosphorusMg => intakes.map((e) => e.phosphorusMg).sum;

  int get totalEnergyKC => intakes.map((e) => e.energyKC).sum;

  int get totalLiquidsMl => intakes.map((e) => e.liquidsMl).sum;

  int getTotalIndicatorAmountByType(IndicatorType type) {
    switch (type) {
      case IndicatorType.energy:
        return this.totalEnergyKC;
      case IndicatorType.liquids:
        return this.totalLiquidsMl;
      case IndicatorType.proteins:
        return this.totalProteinsMg;
      case IndicatorType.sodium:
        return this.totalSodiumMg;
      case IndicatorType.potassium:
        return this.totalPotassiumMg;
      case IndicatorType.phosphorus:
        return this.totalPhosphorusMg;
      default:
        throw ArgumentError.value(
            type, "type", "Unable to map indicator to total amount");
    }
  }

  String getFormattedDailyNorm(IndicatorType type) {
    switch (type) {
      case IndicatorType.energy:
        return "${this.totalEnergyKC} kcal";
      case IndicatorType.liquids:
        return _formatAmount(this.totalLiquidsMl, "ml", "l");
      case IndicatorType.proteins:
      case IndicatorType.sodium:
      case IndicatorType.potassium:
      case IndicatorType.phosphorus:
        return _formatAmount(getTotalIndicatorAmountByType(type), "mg", "g");
      default:
        throw ArgumentError.value(
            type, "type", "Indicator not found while formatting daily norm");
    }
  }
}

extension IntakeExtension on Intake {
  int getIndicatorAmountByType(IndicatorType type) {
    switch (type) {
      case IndicatorType.energy:
        return this.energyKC;
      case IndicatorType.liquids:
        return this.liquidsMl;
      case IndicatorType.proteins:
        return this.proteinsMg;
      case IndicatorType.sodium:
        return this.sodiumMg;
      case IndicatorType.potassium:
        return this.potassiumMg;
      case IndicatorType.phosphorus:
        return this.phosphorusMg;
      default:
        throw ArgumentError.value(
            type, "type", "Unable to map indicator to amount");
    }
  }

  String getFormattedIndicatorConsumption(IndicatorType type) {
    final amount = getIndicatorAmountByType(type);
    switch (type) {
      case IndicatorType.energy:
        return _formatAmount(amount, "kcal", null);
      case IndicatorType.liquids:
        return _formatAmount(amount, "ml", "l");
      case IndicatorType.proteins:
      case IndicatorType.sodium:
      case IndicatorType.potassium:
      case IndicatorType.phosphorus:
        return _formatAmount(amount, "mg", "g");
      default:
        throw ArgumentError.value(
            type, "type", "Unable to map indicator to amount");
    }
  }
}
