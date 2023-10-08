//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'country_request.g.dart';

/// CountryRequest
///
/// Properties:
/// * [name] 
/// * [code] - ISO 3166-1 Alpha 2
/// * [flagSvg] - Download from https://github.com/HatScripts/circle-flags
/// * [languageCode] 
/// * [order] 
@BuiltValue()
abstract class CountryRequest implements Built<CountryRequest, CountryRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  /// ISO 3166-1 Alpha 2
  @BuiltValueField(wireName: r'code')
  String get code;

  /// Download from https://github.com/HatScripts/circle-flags
  @BuiltValueField(wireName: r'flag_svg')
  String get flagSvg;

  @BuiltValueField(wireName: r'language_code')
  String get languageCode;

  @BuiltValueField(wireName: r'order')
  int? get order;

  CountryRequest._();

  factory CountryRequest([void updates(CountryRequestBuilder b)]) = _$CountryRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CountryRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CountryRequest> get serializer => _$CountryRequestSerializer();
}

class _$CountryRequestSerializer implements PrimitiveSerializer<CountryRequest> {
  @override
  final Iterable<Type> types = const [CountryRequest, _$CountryRequest];

  @override
  final String wireName = r'CountryRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CountryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'flag_svg';
    yield serializers.serialize(
      object.flagSvg,
      specifiedType: const FullType(String),
    );
    yield r'language_code';
    yield serializers.serialize(
      object.languageCode,
      specifiedType: const FullType(String),
    );
    if (object.order != null) {
      yield r'order';
      yield serializers.serialize(
        object.order,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CountryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CountryRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'flag_svg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.flagSvg = valueDes;
          break;
        case r'language_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.languageCode = valueDes;
          break;
        case r'order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.order = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CountryRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CountryRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

