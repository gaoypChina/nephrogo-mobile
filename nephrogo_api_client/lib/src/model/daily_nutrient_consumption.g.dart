// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_nutrient_consumption.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyNutrientConsumption extends DailyNutrientConsumption {
  @override
  final int? norm;
  @override
  final int total;

  factory _$DailyNutrientConsumption(
          [void Function(DailyNutrientConsumptionBuilder)? updates]) =>
      (new DailyNutrientConsumptionBuilder()..update(updates))._build();

  _$DailyNutrientConsumption._({this.norm, required this.total}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        total, r'DailyNutrientConsumption', 'total');
  }

  @override
  DailyNutrientConsumption rebuild(
          void Function(DailyNutrientConsumptionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyNutrientConsumptionBuilder toBuilder() =>
      new DailyNutrientConsumptionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyNutrientConsumption &&
        norm == other.norm &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, norm.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyNutrientConsumption')
          ..add('norm', norm)
          ..add('total', total))
        .toString();
  }
}

class DailyNutrientConsumptionBuilder
    implements
        Builder<DailyNutrientConsumption, DailyNutrientConsumptionBuilder> {
  _$DailyNutrientConsumption? _$v;

  int? _norm;
  int? get norm => _$this._norm;
  set norm(int? norm) => _$this._norm = norm;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  DailyNutrientConsumptionBuilder() {
    DailyNutrientConsumption._defaults(this);
  }

  DailyNutrientConsumptionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _norm = $v.norm;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyNutrientConsumption other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DailyNutrientConsumption;
  }

  @override
  void update(void Function(DailyNutrientConsumptionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyNutrientConsumption build() => _build();

  _$DailyNutrientConsumption _build() {
    final _$result = _$v ??
        new _$DailyNutrientConsumption._(
            norm: norm,
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'DailyNutrientConsumption', 'total'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
