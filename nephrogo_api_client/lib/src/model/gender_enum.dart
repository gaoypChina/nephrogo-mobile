//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gender_enum.g.dart';

class GenderEnum extends EnumClass {

  /// * `Male` - Vyras * `Female` - Moteris
  @BuiltValueEnumConst(wireName: r'Male')
  static const GenderEnum male = _$male;
  /// * `Male` - Vyras * `Female` - Moteris
  @BuiltValueEnumConst(wireName: r'Female')
  static const GenderEnum female = _$female;

  static Serializer<GenderEnum> get serializer => _$genderEnumSerializer;

  const GenderEnum._(String name): super(name);

  static BuiltSet<GenderEnum> get values => _$values;
  static GenderEnum valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class GenderEnumMixin = Object with _$GenderEnumMixin;

