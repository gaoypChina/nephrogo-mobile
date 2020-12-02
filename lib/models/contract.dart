import 'package:json_annotation/json_annotation.dart';
import 'package:faker/faker.dart';
import 'package:nephrolog/extensions/DateExtensions.dart';

part 'contract.g.dart';

enum IntakesScreenType {
  energy,
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

  static Product generateDummy() {
    return Product(
      random.integer(10000000),
      faker.food.dish(),
      random.element([ProductKind.food, ProductKind.drink]),
    );
  }

  static List<Product> generateDummies() {
    return List<Product>.generate(30, (i) => Product.generateDummy());
  }
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

  @JsonKey()
  final int potassiumMg;

  @JsonKey()
  final int proteinsMg;

  @JsonKey()
  final int sodiumMg;

  @JsonKey()
  final int phosphorusMg;

  @JsonKey()
  final int energyKC;

  @JsonKey()
  final int liquidsMl;

  const Intake(
    this.id,
    this.product,
    this.dateTime,
    this.amountG,
    this.potassiumMg,
    this.proteinsMg,
    this.sodiumMg,
    this.phosphorusMg,
    this.energyKC,
    this.liquidsMl,
  );

  factory Intake.fromJson(Map<String, dynamic> json) => _$IntakeFromJson(json);

  Map<String, dynamic> toJson() => _$IntakeToJson(this);

  //Pvz.žmogaus, kurio idealus svoris 62 kg ir jis atlieka peritonines dializes bei laikosi rekomenduojamos dietos, dienos suvestinė pvz atrodytų taip:
  // Na 2,2 g
  // K 3 g
  // P 0,8 g
  // Baltymai 68,2 g
  // Vanduo 1100 ml
  // Energija 1550 kcal

  // Arba jei 80kg, galėtų atrodyt pvz taip
  // Na 2.3g
  // K 4g
  // P 1.1g
  // Balt 96 g
  // Vanduo 1100 ml (nedidelis, nes vandens galima suvartoti max 1000ml plius tos dienos šlapimo kiekis, o  šie su dializėmis pacientai dažniausiai neturi šlapimo, būna tik apie 100ml, kartais mažiau)
  // Energija 2800 kcal
  static Intake generateDummy({int day = 1}) {
    return Intake(
      random.integer(10000000),
      Product.generateDummy(),
      faker.date.dateTime().copyWith(year: 2020, month: 12, day: day),
      random.integer(3000),
      random.integer(1100),
      random.integer(80000),
      random.integer(2200),
      random.integer(2000),
      random.integer(3000),
      random.integer(1500),
    );
  }

  static List<Intake> generateDummies({int n = 100, int day = 1}) {
    final l = List.generate(n, (i) => Intake.generateDummy());
    l.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return l;
  }
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
  final int amountG;

  @JsonKey()
  final int potassiumMg;

  @JsonKey()
  final int proteinsMg;

  @JsonKey()
  final int sodiumMg;

  @JsonKey()
  final int phosphorusMg;

  @JsonKey()
  final int energyKC;

  @JsonKey()
  final int liquidsMl;

  const DailyIntake(
    this.id,
    this.date,
    this.intakes,
    this.amountG,
    this.potassiumMg,
    this.proteinsMg,
    this.sodiumMg,
    this.phosphorusMg,
    this.energyKC,
    this.liquidsMl,
  );

  factory DailyIntake.fromJson(Map<String, dynamic> json) =>
      _$DailyIntakeFromJson(json);

  Map<String, dynamic> toJson() => _$DailyIntakeToJson(this);

  static DailyIntake generateDummy({int day: 1}) {
    return DailyIntake(
      random.integer(10000000),
      DateTime(2020, 12, day),
      Intake.generateDummies(
        n: faker.randomGenerator.integer(10, min: 1),
        day: day,
      ),
      random.integer(3000),
      random.integer(1100),
      random.integer(80000),
      random.integer(2200),
      random.integer(2000),
      random.integer(3000),
      random.integer(1500),
    );
  }

  static List<DailyIntake> generateDummies() {
    return List.generate(30, (index) => DailyIntake.generateDummy(day: index))
        .reversed
        .toList();
  }
}
