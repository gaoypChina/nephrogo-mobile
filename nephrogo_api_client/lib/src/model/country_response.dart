//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/country.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'country_response.g.dart';

/// CountryResponse
///
/// Properties:
/// * [selectedCountry] 
/// * [suggestedCountry] 
/// * [countries] 
@BuiltValue()
abstract class CountryResponse implements Built<CountryResponse, CountryResponseBuilder> {
  @BuiltValueField(wireName: r'selected_country')
  Country? get selectedCountry;

  @BuiltValueField(wireName: r'suggested_country')
  Country? get suggestedCountry;

  @BuiltValueField(wireName: r'countries')
  BuiltList<Country> get countries;

  CountryResponse._();

  factory CountryResponse([void updates(CountryResponseBuilder b)]) = _$CountryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CountryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CountryResponse> get serializer => _$CountryResponseSerializer();
}

class _$CountryResponseSerializer implements PrimitiveSerializer<CountryResponse> {
  @override
  final Iterable<Type> types = const [CountryResponse, _$CountryResponse];

  @override
  final String wireName = r'CountryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CountryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'selected_country';
    yield object.selectedCountry == null ? null : serializers.serialize(
      object.selectedCountry,
      specifiedType: const FullType.nullable(Country),
    );
    yield r'suggested_country';
    yield object.suggestedCountry == null ? null : serializers.serialize(
      object.suggestedCountry,
      specifiedType: const FullType.nullable(Country),
    );
    yield r'countries';
    yield serializers.serialize(
      object.countries,
      specifiedType: const FullType(BuiltList, [FullType(Country)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CountryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CountryResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'selected_country':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Country),
          ) as Country?;
          if (valueDes == null) continue;
          result.selectedCountry.replace(valueDes);
          break;
        case r'suggested_country':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Country),
          ) as Country?;
          if (valueDes == null) continue;
          result.suggestedCountry.replace(valueDes);
          break;
        case r'countries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Country)]),
          ) as BuiltList<Country>;
          result.countries.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CountryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CountryResponseBuilder();
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

