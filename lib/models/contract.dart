import 'package:json_annotation/json_annotation.dart';
import 'package:faker/faker.dart';
import 'package:nephrolog/extensions/date_extensions.dart';

// Used internally
enum Nutrient {
  potassium,
  proteins,
  sodium,
  phosphorus,
  liquids,
  energy,
}

enum HealthIndicator {
  bloodPressure,
  weight,
  urine,
  severityOfSwelling,
  numberOfSwellings,
  wellBeing,
  appetite,
  shortnessOfBreath,
}

// End of used internally

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
      random.integer(4400 ~/ ratio),
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
  final DateTime date;

  @JsonKey()
  final List<Intake> intakes;

  @JsonKey()
  final DailyIntakeNorms userIntakeNorms;

  const DailyIntake(
    this.date,
    this.intakes,
    this.userIntakeNorms,
  );

  static DailyIntake generateDummy(DateTime dateTime) {
    return DailyIntake(
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
    final toStartOfDay = to.startOfDay();

    for (var date = from;
        date.isBefore(toStartOfDay);
        date = date.add(Duration(days: 1))) {
      dailyIntakes.add(DailyIntake.generateDummy(date));
    }

    return dailyIntakes;
  }
}

@JsonSerializable()
class UserIntakesResponse {
  @JsonKey()
  final List<DailyIntake> dailyIntakes;

  UserIntakesResponse(this.dailyIntakes);

  static UserIntakesResponse generateDummy(DateTime from, DateTime to) {
    return UserIntakesResponse(DailyIntake.generateDummies(from, to));
  }
}

@JsonSerializable()
class DailyHealthStatus {
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
  final int wellBeing;

  @JsonKey()
  final int appetite;

  @JsonKey()
  final int shortnessOfBreath;

  const DailyHealthStatus(
    this.id,
    this.date,
    this.systolicBloodPressure,
    this.diastolicBloodPressure,
    this.weight,
    this.urineMl,
    this.severityOfSwelling,
    this.numberOfSwellings,
    this.wellBeing,
    this.appetite,
    this.shortnessOfBreath,
  );

  static DailyHealthStatus generateDummy(DateTime date) {
    return DailyHealthStatus(
      random.integer(10000000),
      date,
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
}

@JsonSerializable()
class UserHealthStatusResponse {
  final List<DailyHealthStatus> dailyHealthStatuses;

  const UserHealthStatusResponse(this.dailyHealthStatuses);

  static UserHealthStatusResponse generateDummy(DateTime from, DateTime to) {
    final dailyHealthStatuses = <DailyHealthStatus>[];
    final toStartOfDay = to.startOfDay();

    for (var date = from;
        date.isBefore(toStartOfDay);
        date = date.add(Duration(days: 1))) {
      dailyHealthStatuses.add(DailyHealthStatus.generateDummy(date));
    }

    return UserHealthStatusResponse(dailyHealthStatuses);
  }
}
