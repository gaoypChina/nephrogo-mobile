// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_kind_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProductKindEnum _$unknown = const ProductKindEnum._('unknown');
const ProductKindEnum _$food = const ProductKindEnum._('food');
const ProductKindEnum _$drink = const ProductKindEnum._('drink');

ProductKindEnum _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'food':
      return _$food;
    case 'drink':
      return _$drink;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ProductKindEnum> _$values =
    new BuiltSet<ProductKindEnum>(const <ProductKindEnum>[
  _$unknown,
  _$food,
  _$drink,
]);

class _$ProductKindEnumMeta {
  const _$ProductKindEnumMeta();
  ProductKindEnum get unknown => _$unknown;
  ProductKindEnum get food => _$food;
  ProductKindEnum get drink => _$drink;
  ProductKindEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<ProductKindEnum> get values => _$values;
}

abstract class _$ProductKindEnumMixin {
  // ignore: non_constant_identifier_names
  _$ProductKindEnumMeta get ProductKindEnum => const _$ProductKindEnumMeta();
}

Serializer<ProductKindEnum> _$productKindEnumSerializer =
    new _$ProductKindEnumSerializer();

class _$ProductKindEnumSerializer
    implements PrimitiveSerializer<ProductKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'Unknown',
    'food': 'Food',
    'drink': 'Drink',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unknown': 'unknown',
    'Food': 'food',
    'Drink': 'drink',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductKindEnum];
  @override
  final String wireName = 'ProductKindEnum';

  @override
  Object serialize(Serializers serializers, ProductKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductKindEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
