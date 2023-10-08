//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_kind_enum.g.dart';

class ProductKindEnum extends EnumClass {

  /// * `Unknown` - Unknown * `Food` - Food * `Drink` - Drink
  @BuiltValueEnumConst(wireName: r'Unknown')
  static const ProductKindEnum unknown = _$unknown;
  /// * `Unknown` - Unknown * `Food` - Food * `Drink` - Drink
  @BuiltValueEnumConst(wireName: r'Food')
  static const ProductKindEnum food = _$food;
  /// * `Unknown` - Unknown * `Food` - Food * `Drink` - Drink
  @BuiltValueEnumConst(wireName: r'Drink')
  static const ProductKindEnum drink = _$drink;

  static Serializer<ProductKindEnum> get serializer => _$productKindEnumSerializer;

  const ProductKindEnum._(String name): super(name);

  static BuiltSet<ProductKindEnum> get values => _$values;
  static ProductKindEnum valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ProductKindEnumMixin = Object with _$ProductKindEnumMixin;

