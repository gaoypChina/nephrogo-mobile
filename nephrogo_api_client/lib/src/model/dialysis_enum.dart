//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dialysis_enum.g.dart';

class DialysisEnum extends EnumClass {

  /// * `Unknown` - Nežinoma * `AutomaticPeritonealDialysis` - Automatinė peritoninė dializė * `ManualPeritonealDialysis` - Ambulatorinė peritoninė dializė * `Hemodialysis` - Hemodializė * `PostTransplant` - Neatlieka, po inkstų transplantacijos * `NotPerformed` - Neatlieka
  @BuiltValueEnumConst(wireName: r'Unknown')
  static const DialysisEnum unknown = _$unknown;
  /// * `Unknown` - Nežinoma * `AutomaticPeritonealDialysis` - Automatinė peritoninė dializė * `ManualPeritonealDialysis` - Ambulatorinė peritoninė dializė * `Hemodialysis` - Hemodializė * `PostTransplant` - Neatlieka, po inkstų transplantacijos * `NotPerformed` - Neatlieka
  @BuiltValueEnumConst(wireName: r'AutomaticPeritonealDialysis')
  static const DialysisEnum automaticPeritonealDialysis = _$automaticPeritonealDialysis;
  /// * `Unknown` - Nežinoma * `AutomaticPeritonealDialysis` - Automatinė peritoninė dializė * `ManualPeritonealDialysis` - Ambulatorinė peritoninė dializė * `Hemodialysis` - Hemodializė * `PostTransplant` - Neatlieka, po inkstų transplantacijos * `NotPerformed` - Neatlieka
  @BuiltValueEnumConst(wireName: r'ManualPeritonealDialysis')
  static const DialysisEnum manualPeritonealDialysis = _$manualPeritonealDialysis;
  /// * `Unknown` - Nežinoma * `AutomaticPeritonealDialysis` - Automatinė peritoninė dializė * `ManualPeritonealDialysis` - Ambulatorinė peritoninė dializė * `Hemodialysis` - Hemodializė * `PostTransplant` - Neatlieka, po inkstų transplantacijos * `NotPerformed` - Neatlieka
  @BuiltValueEnumConst(wireName: r'Hemodialysis')
  static const DialysisEnum hemodialysis = _$hemodialysis;
  /// * `Unknown` - Nežinoma * `AutomaticPeritonealDialysis` - Automatinė peritoninė dializė * `ManualPeritonealDialysis` - Ambulatorinė peritoninė dializė * `Hemodialysis` - Hemodializė * `PostTransplant` - Neatlieka, po inkstų transplantacijos * `NotPerformed` - Neatlieka
  @BuiltValueEnumConst(wireName: r'PostTransplant')
  static const DialysisEnum postTransplant = _$postTransplant;
  /// * `Unknown` - Nežinoma * `AutomaticPeritonealDialysis` - Automatinė peritoninė dializė * `ManualPeritonealDialysis` - Ambulatorinė peritoninė dializė * `Hemodialysis` - Hemodializė * `PostTransplant` - Neatlieka, po inkstų transplantacijos * `NotPerformed` - Neatlieka
  @BuiltValueEnumConst(wireName: r'NotPerformed')
  static const DialysisEnum notPerformed = _$notPerformed;

  static Serializer<DialysisEnum> get serializer => _$dialysisEnumSerializer;

  const DialysisEnum._(String name): super(name);

  static BuiltSet<DialysisEnum> get values => _$values;
  static DialysisEnum valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DialysisEnumMixin = Object with _$DialysisEnumMixin;

