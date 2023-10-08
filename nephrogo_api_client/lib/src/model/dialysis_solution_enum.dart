//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dialysis_solution_enum.g.dart';

class DialysisSolutionEnum extends EnumClass {

  /// * `Unknown` - Unknown * `Yellow` - Yellow * `Green` - Green * `Orange` - Orange * `Blue` - Blue * `Purple` - Purple
  @BuiltValueEnumConst(wireName: r'Unknown')
  static const DialysisSolutionEnum unknown = _$unknown;
  /// * `Unknown` - Unknown * `Yellow` - Yellow * `Green` - Green * `Orange` - Orange * `Blue` - Blue * `Purple` - Purple
  @BuiltValueEnumConst(wireName: r'Yellow')
  static const DialysisSolutionEnum yellow = _$yellow;
  /// * `Unknown` - Unknown * `Yellow` - Yellow * `Green` - Green * `Orange` - Orange * `Blue` - Blue * `Purple` - Purple
  @BuiltValueEnumConst(wireName: r'Green')
  static const DialysisSolutionEnum green = _$green;
  /// * `Unknown` - Unknown * `Yellow` - Yellow * `Green` - Green * `Orange` - Orange * `Blue` - Blue * `Purple` - Purple
  @BuiltValueEnumConst(wireName: r'Orange')
  static const DialysisSolutionEnum orange = _$orange;
  /// * `Unknown` - Unknown * `Yellow` - Yellow * `Green` - Green * `Orange` - Orange * `Blue` - Blue * `Purple` - Purple
  @BuiltValueEnumConst(wireName: r'Blue')
  static const DialysisSolutionEnum blue = _$blue;
  /// * `Unknown` - Unknown * `Yellow` - Yellow * `Green` - Green * `Orange` - Orange * `Blue` - Blue * `Purple` - Purple
  @BuiltValueEnumConst(wireName: r'Purple')
  static const DialysisSolutionEnum purple = _$purple;

  static Serializer<DialysisSolutionEnum> get serializer => _$dialysisSolutionEnumSerializer;

  const DialysisSolutionEnum._(String name): super(name);

  static BuiltSet<DialysisSolutionEnum> get values => _$values;
  static DialysisSolutionEnum valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DialysisSolutionEnumMixin = Object with _$DialysisSolutionEnumMixin;

