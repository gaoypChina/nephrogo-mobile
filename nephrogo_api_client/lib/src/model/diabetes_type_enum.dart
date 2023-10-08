//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'diabetes_type_enum.g.dart';

class DiabetesTypeEnum extends EnumClass {

  /// * `Unknown` - Nežinoma * `Type1` - 1 tipo * `Type2` - 2 tipo * `No` - Neserga
  @BuiltValueEnumConst(wireName: r'Unknown')
  static const DiabetesTypeEnum unknown = _$unknown;
  /// * `Unknown` - Nežinoma * `Type1` - 1 tipo * `Type2` - 2 tipo * `No` - Neserga
  @BuiltValueEnumConst(wireName: r'Type1')
  static const DiabetesTypeEnum type1 = _$type1;
  /// * `Unknown` - Nežinoma * `Type1` - 1 tipo * `Type2` - 2 tipo * `No` - Neserga
  @BuiltValueEnumConst(wireName: r'Type2')
  static const DiabetesTypeEnum type2 = _$type2;
  /// * `Unknown` - Nežinoma * `Type1` - 1 tipo * `Type2` - 2 tipo * `No` - Neserga
  @BuiltValueEnumConst(wireName: r'No')
  static const DiabetesTypeEnum no = _$no;

  static Serializer<DiabetesTypeEnum> get serializer => _$diabetesTypeEnumSerializer;

  const DiabetesTypeEnum._(String name): super(name);

  static BuiltSet<DiabetesTypeEnum> get values => _$values;
  static DiabetesTypeEnum valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DiabetesTypeEnumMixin = Object with _$DiabetesTypeEnumMixin;

