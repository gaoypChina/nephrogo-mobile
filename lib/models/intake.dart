import 'package:json_annotation/json_annotation.dart';

part 'intake.g.dart';

enum Indicator {
  energy,
  carbohydrates,
  proteins,
  liquids,
  sodium,
  potassium,
  phosphorus,
}

enum ProductKind {
  @JsonValue(0)
  unknown,
  @JsonValue(1)
  food,
  @JsonValue(2)
  drink,
}

@JsonSerializable()
class Product {
  @JsonKey()
  final int id;

  @JsonKey()
  final String name;

  @JsonKey(unknownEnumValue: ProductKind.unknown)
  final ProductKind kind;

  const Product(
    this.id,
    this.name,
    this.kind,
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Intake {
  @JsonKey()
  final int id;

  @JsonKey()
  final Product product;
  @JsonKey()
  final DateTime dateTime;

  @JsonKey()
  final int amountG;

  const Intake(
    this.id,
    this.product,
    this.dateTime,
    this.amountG,
  );

  factory Intake.fromJson(Map<String, dynamic> json) => _$IntakeFromJson(json);

  Map<String, dynamic> toJson() => _$IntakeToJson(this);

  static final dummy = [
    Intake(
      1,
      Product(
        1,
        "Salyklinis alus",
        ProductKind.drink,
      ),
      DateTime.now(),
      10,
    ),
    Intake(
      2,
      Product(
        2,
        "Lasisa",
        ProductKind.food,
      ),
      DateTime.now(),
      100,
    ),
    Intake(
      3,
      Product(
        3,
        "Kiauliena",
        ProductKind.food,
      ),
      DateTime.now(),
      500,
    ),
  ];
}

@JsonSerializable()
class IndicatorConsumption {
  @JsonKey()
  final int consumed;

  @JsonKey()
  final int norm;

  @JsonKey()
  final String unit;

  const IndicatorConsumption(
    this.consumed,
    this.norm,
    this.unit,
  );

  factory IndicatorConsumption.fromJson(Map<String, dynamic> json) =>
      _$IndicatorConsumptionFromJson(json);

  Map<String, dynamic> toJson() => _$IndicatorConsumptionToJson(this);
}

@JsonSerializable()
class DailyIntake {
  @JsonKey()
  final int id;

  @JsonKey()
  final DateTime date;

  @JsonKey()
  final List<Intake> intakes;

  @JsonKey()
  final IndicatorConsumption energy;

  @JsonKey()
  final IndicatorConsumption carbohydrates;

  @JsonKey()
  final IndicatorConsumption proteins;

  @JsonKey()
  final IndicatorConsumption liquids;

  @JsonKey()
  final IndicatorConsumption sodium;

  @JsonKey()
  final IndicatorConsumption potassium;

  @JsonKey()
  final IndicatorConsumption phosphorus;

  const DailyIntake(
    this.id,
    this.date,
    this.intakes,
    this.energy,
    this.carbohydrates,
    this.proteins,
    this.liquids,
    this.sodium,
    this.potassium,
    this.phosphorus,
  );

  factory DailyIntake.fromJson(Map<String, dynamic> json) =>
      _$DailyIntakeFromJson(json);

  Map<String, dynamic> toJson() => _$DailyIntakeToJson(this);
}
