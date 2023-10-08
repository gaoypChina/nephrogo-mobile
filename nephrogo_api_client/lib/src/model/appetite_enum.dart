//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'appetite_enum.g.dart';

class AppetiteEnum extends EnumClass {

  /// * `Unknown` - Unknown * `Perfect` - Perfect * `Good` - Good * `Average` - Average * `Bad` - Bad * `VeryBad` - Verybad
  @BuiltValueEnumConst(wireName: r'Unknown')
  static const AppetiteEnum unknown = _$unknown;
  /// * `Unknown` - Unknown * `Perfect` - Perfect * `Good` - Good * `Average` - Average * `Bad` - Bad * `VeryBad` - Verybad
  @BuiltValueEnumConst(wireName: r'Perfect')
  static const AppetiteEnum perfect = _$perfect;
  /// * `Unknown` - Unknown * `Perfect` - Perfect * `Good` - Good * `Average` - Average * `Bad` - Bad * `VeryBad` - Verybad
  @BuiltValueEnumConst(wireName: r'Good')
  static const AppetiteEnum good = _$good;
  /// * `Unknown` - Unknown * `Perfect` - Perfect * `Good` - Good * `Average` - Average * `Bad` - Bad * `VeryBad` - Verybad
  @BuiltValueEnumConst(wireName: r'Average')
  static const AppetiteEnum average = _$average;
  /// * `Unknown` - Unknown * `Perfect` - Perfect * `Good` - Good * `Average` - Average * `Bad` - Bad * `VeryBad` - Verybad
  @BuiltValueEnumConst(wireName: r'Bad')
  static const AppetiteEnum bad = _$bad;
  /// * `Unknown` - Unknown * `Perfect` - Perfect * `Good` - Good * `Average` - Average * `Bad` - Bad * `VeryBad` - Verybad
  @BuiltValueEnumConst(wireName: r'VeryBad')
  static const AppetiteEnum veryBad = _$veryBad;

  static Serializer<AppetiteEnum> get serializer => _$appetiteEnumSerializer;

  const AppetiteEnum._(String name): super(name);

  static BuiltSet<AppetiteEnum> get values => _$values;
  static AppetiteEnum valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AppetiteEnumMixin = Object with _$AppetiteEnumMixin;

