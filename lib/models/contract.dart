import 'package:nephrogo_api_client/nephrogo_api_client.dart';

import 'date.dart';

enum Nutrient {
  potassium,
  proteins,
  sodium,
  phosphorus,
  liquids,
  energy,
  fat,
  carbohydrate,
}

enum HealthIndicator {
  bloodPressure,
  pulse,
  weight,
  urine,
  glucose,
  swellings,
  severityOfSwelling,
  wellBeing,
  appetite,
  shortnessOfBreath,
}

class DailyMealTypeNutrientConsumption {
  final Nutrient nutrient;
  final Date date;
  final MealTypeEnum mealType;
  final int dailyTotal;
  final int drinksTotal;
  final int foodTotal;

  double get percentage =>
      dailyTotal != 0 ? (drinksTotal + foodTotal) / dailyTotal : 0;

  double get foodPercentage => dailyTotal != 0 ? foodTotal / dailyTotal : 0;

  double get drinksPercentage => dailyTotal != 0 ? drinksTotal / dailyTotal : 0;

  DailyMealTypeNutrientConsumption({
    required this.nutrient,
    required this.date,
    required this.mealType,
    required this.drinksTotal,
    required this.foodTotal,
    required this.dailyTotal,
  });
}
