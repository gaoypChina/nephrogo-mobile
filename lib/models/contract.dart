import 'package:json_annotation/json_annotation.dart';
import 'package:faker/faker.dart';
import 'package:nephrolog/extensions/date_extensions.dart';

// Used IndicatorType internally
enum IndicatorType {
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
  static Intake generateDummy({int n, DateTime dateTime}) {
    final ratio = n - 0.5 / n;
    return Intake(
      random.integer(10000000),
      Product.generateDummy(),
      faker.date.dateTime().copyWith(
            year: dateTime.year,
            month: dateTime.month,
            day: dateTime.day,
          ),
      random.integer(3000 ~/ ratio),
      random.integer(1100 ~/ ratio),
      random.integer(80000 ~/ ratio),
      random.integer(2200 ~/ ratio),
      random.integer(2000 ~/ ratio),
      random.integer(3000 ~/ ratio),
      random.integer(1500 ~/ ratio),
    );
  }

  static List<Intake> generateDummies({int n, DateTime dateTime}) {
    final l =
        List.generate(n, (i) => Intake.generateDummy(n: n, dateTime: dateTime));
    l.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return l;
  }
}

@JsonSerializable()
class DailyIntakeNorms {
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

  const DailyIntakeNorms(
    this.potassiumMg,
    this.proteinsMg,
    this.sodiumMg,
    this.phosphorusMg,
    this.energyKC,
    this.liquidsMl,
  );

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
  static DailyIntakeNorms generateDummy() {
    return DailyIntakeNorms(
      4000,
      68200,
      2300,
      1100,
      2800,
      1100,
    );
  }
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
  final DailyIntakeNorms userIntakeNorms;

  const DailyIntake(
    this.id,
    this.date,
    this.intakes,
    this.userIntakeNorms,
  );

  static DailyIntake generateDummy(DateTime dateTime) {
    return DailyIntake(
      random.integer(10000000),
      dateTime,
      Intake.generateDummies(
        n: faker.randomGenerator.integer(10, min: 1),
        dateTime: dateTime,
      ),
      DailyIntakeNorms.generateDummy(),
    );
  }

  static List<DailyIntake> generateDummies(DateTime from, DateTime to) {
    final dailyIntakes = <DailyIntake>[];

    var date = from;
    while (date.isBefore(to)) {
      dailyIntakes.add(DailyIntake.generateDummy(date));

      date.add(Duration(days: 1));
    }

    return dailyIntakes;
  }
}

@JsonSerializable()
class DailyIntakesResponse {
  @JsonKey()
  final List<DailyIntake> dailyIntakes;

  DailyIntakesResponse(this.dailyIntakes);

  static DailyIntakesResponse generateDummy(DateTime from, DateTime to) {
    return DailyIntakesResponse(DailyIntake.generateDummies(from, to));
  }
}

@JsonSerializable()
class DailyHealthIndicators {
  @JsonKey()
  final int id;

  @JsonKey()
  final DateTime date;

  @JsonKey()
  final int systolicBloodPressure;
  @JsonKey()
  final int diastolicBloodPressure;

  @JsonKey()
  final int weight;

  @JsonKey()
  final int urineMl;

  @JsonKey()
  final int severityOfSwelling;

  @JsonKey()
  final int numberOfSwellings;

  @JsonKey()
  final int feelingAtEase;

  @JsonKey()
  final int apetite;

  @JsonKey()
  final int shortnessOfBreath;

  const DailyHealthIndicators(
    this.id,
    this.date,
    this.systolicBloodPressure,
    this.diastolicBloodPressure,
    this.weight,
    this.urineMl,
    this.severityOfSwelling,
    this.numberOfSwellings,
    this.feelingAtEase,
    this.apetite,
    this.shortnessOfBreath,
  );

  static DailyHealthIndicators generateDummy({int day: 1}) {
    return DailyHealthIndicators(
      random.integer(10000000),
      DateTime(2020, 12, day),
      random.integer(200, min: 130),
      random.integer(120, min: 60),
      random.integer(110, min: 100),
      random.integer(700, min: 400),
      random.integer(4, min: 0),
      random.integer(4, min: 0),
      random.integer(5, min: 1),
      random.integer(5, min: 1),
      random.integer(4, min: 0),
    );
  }

  static List<DailyHealthIndicators> generateDummies() {
    return List.generate(
            30, (index) => DailyHealthIndicators.generateDummy(day: index))
        .reversed
        .toList();
  }
}
