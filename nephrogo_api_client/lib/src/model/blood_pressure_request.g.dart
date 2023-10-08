// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BloodPressureRequest extends BloodPressureRequest {
  @override
  final int systolicBloodPressure;
  @override
  final int diastolicBloodPressure;
  @override
  final DateTime measuredAt;

  factory _$BloodPressureRequest(
          [void Function(BloodPressureRequestBuilder)? updates]) =>
      (new BloodPressureRequestBuilder()..update(updates))._build();

  _$BloodPressureRequest._(
      {required this.systolicBloodPressure,
      required this.diastolicBloodPressure,
      required this.measuredAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(systolicBloodPressure,
        r'BloodPressureRequest', 'systolicBloodPressure');
    BuiltValueNullFieldError.checkNotNull(diastolicBloodPressure,
        r'BloodPressureRequest', 'diastolicBloodPressure');
    BuiltValueNullFieldError.checkNotNull(
        measuredAt, r'BloodPressureRequest', 'measuredAt');
  }

  @override
  BloodPressureRequest rebuild(
          void Function(BloodPressureRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BloodPressureRequestBuilder toBuilder() =>
      new BloodPressureRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BloodPressureRequest &&
        systolicBloodPressure == other.systolicBloodPressure &&
        diastolicBloodPressure == other.diastolicBloodPressure &&
        measuredAt == other.measuredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, systolicBloodPressure.hashCode);
    _$hash = $jc(_$hash, diastolicBloodPressure.hashCode);
    _$hash = $jc(_$hash, measuredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BloodPressureRequest')
          ..add('systolicBloodPressure', systolicBloodPressure)
          ..add('diastolicBloodPressure', diastolicBloodPressure)
          ..add('measuredAt', measuredAt))
        .toString();
  }
}

class BloodPressureRequestBuilder
    implements Builder<BloodPressureRequest, BloodPressureRequestBuilder> {
  _$BloodPressureRequest? _$v;

  int? _systolicBloodPressure;
  int? get systolicBloodPressure => _$this._systolicBloodPressure;
  set systolicBloodPressure(int? systolicBloodPressure) =>
      _$this._systolicBloodPressure = systolicBloodPressure;

  int? _diastolicBloodPressure;
  int? get diastolicBloodPressure => _$this._diastolicBloodPressure;
  set diastolicBloodPressure(int? diastolicBloodPressure) =>
      _$this._diastolicBloodPressure = diastolicBloodPressure;

  DateTime? _measuredAt;
  DateTime? get measuredAt => _$this._measuredAt;
  set measuredAt(DateTime? measuredAt) => _$this._measuredAt = measuredAt;

  BloodPressureRequestBuilder() {
    BloodPressureRequest._defaults(this);
  }

  BloodPressureRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _systolicBloodPressure = $v.systolicBloodPressure;
      _diastolicBloodPressure = $v.diastolicBloodPressure;
      _measuredAt = $v.measuredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BloodPressureRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BloodPressureRequest;
  }

  @override
  void update(void Function(BloodPressureRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BloodPressureRequest build() => _build();

  _$BloodPressureRequest _build() {
    final _$result = _$v ??
        new _$BloodPressureRequest._(
            systolicBloodPressure: BuiltValueNullFieldError.checkNotNull(
                systolicBloodPressure,
                r'BloodPressureRequest',
                'systolicBloodPressure'),
            diastolicBloodPressure: BuiltValueNullFieldError.checkNotNull(
                diastolicBloodPressure,
                r'BloodPressureRequest',
                'diastolicBloodPressure'),
            measuredAt: BuiltValueNullFieldError.checkNotNull(
                measuredAt, r'BloodPressureRequest', 'measuredAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
