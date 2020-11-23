import 'package:json_annotation/json_annotation.dart';

part 'intake.g.dart';

enum ProductKind {
  @JsonValue(0)
  UNKNOWN,
  @JsonValue(1)
  FOOD,
  @JsonValue(2)
  DRINK,
}

@JsonSerializable()
class Product {
  @JsonKey()
  final int id;

  @JsonKey()
  final String name;

  @JsonKey(unknownEnumValue: ProductKind.UNKNOWN)
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
        ProductKind.DRINK,
      ),
      DateTime.now(),
      10,
    ),
    Intake(
      2,
      Product(
        2,
        "Lasisa",
        ProductKind.FOOD,
      ),
      DateTime.now(),
      100,
    ),
    Intake(
      3,
      Product(
        3,
        "Kiauliena",
        ProductKind.FOOD,
      ),
      DateTime.now(),
      500,
    ),
  ];
}
