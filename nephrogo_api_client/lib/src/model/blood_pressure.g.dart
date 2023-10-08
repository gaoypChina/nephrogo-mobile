// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BloodPressure extends BloodPressure {
  @override
  final int id;
  @override
  final int systolicBloodPressure;
  @override
  final int diastolicBloodPressure;
  @override
  final DateTime measuredAt;

  factory _$BloodPressure([void Function(BloodPressureBuilder)? updates]) =>
      (new BloodPressureBuilder()..update(updates))._build();

  _$BloodPressure._(
      {required this.id,
      required this.systolicBloodPressure,
      required this.diastolicBloodPressure,
      required this.measuredAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'BloodPressure', 'id');
    BuiltValueNullFieldError.checkNotNull(
        systolicBloodPressure, r'BloodPressure', 'systolicBloodPressure');
    BuiltValueNullFieldError.checkNotNull(
        diastolicBloodPressure, r'BloodPressure', 'diastolicBloodPressure');
    BuiltValueNullFieldError.checkNotNull(
        measuredAt, r'BloodPressure', 'measuredAt');
  }

  @override
  BloodPressure rebuild(void Function(BloodPressureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BloodPressureBuilder toBuilder() => new BloodPressureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BloodPressure &&
        id == other.id &&
        systolicBloodPressure == other.systolicBloodPressure &&
        diastolicBloodPressure == other.diastolicBloodPressure &&
        measuredAt == other.measuredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, systolicBloodPressure.hashCode);
    _$hash = $jc(_$hash, diastolicBloodPressure.hashCode);
    _$hash = $jc(_$hash, measuredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BloodPressure')
          ..add('id', id)
          ..add('systolicBloodPressure', systolicBloodPressure)
          ..add('diastolicBloodPressure', diastolicBloodPressure)
          ..add('measuredAt', measuredAt))
        .toString();
  }
}

class BloodPressureBuilder
    implements Builder<BloodPressure, BloodPressureBuilder> {
  _$BloodPressure? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  BloodPressureBuilder() {
    BloodPressure._defaults(this);
  }

  BloodPressureBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _systolicBloodPressure = $v.systolicBloodPressure;
      _diastolicBloodPressure = $v.diastolicBloodPressure;
      _measuredAt = $v.measuredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BloodPressure other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BloodPressure;
  }

  @override
  void update(void Function(BloodPressureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BloodPressure build() => _build();

  _$BloodPressure _build() {
    final _$result = _$v ??
        new _$BloodPressure._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'BloodPressure', 'id'),
            systolicBloodPressure: BuiltValueNullFieldError.checkNotNull(
                systolicBloodPressure,
                r'BloodPressure',
                'systolicBloodPressure'),
            diastolicBloodPressure: BuiltValueNullFieldError.checkNotNull(
                diastolicBloodPressure,
                r'BloodPressure',
                'diastolicBloodPressure'),
            measuredAt: BuiltValueNullFieldError.checkNotNull(
                measuredAt, r'BloodPressure', 'measuredAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
