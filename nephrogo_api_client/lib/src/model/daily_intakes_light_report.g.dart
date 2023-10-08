// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_intakes_light_report.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyIntakesLightReport extends DailyIntakesLightReport {
  @override
  final Date date;
  @override
  final DailyNutrientNormsWithTotals nutrientNormsAndTotals;

  factory _$DailyIntakesLightReport(
          [void Function(DailyIntakesLightReportBuilder)? updates]) =>
      (new DailyIntakesLightReportBuilder()..update(updates))._build();

  _$DailyIntakesLightReport._(
      {required this.date, required this.nutrientNormsAndTotals})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        date, r'DailyIntakesLightReport', 'date');
    BuiltValueNullFieldError.checkNotNull(nutrientNormsAndTotals,
        r'DailyIntakesLightReport', 'nutrientNormsAndTotals');
  }

  @override
  DailyIntakesLightReport rebuild(
          void Function(DailyIntakesLightReportBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyIntakesLightReportBuilder toBuilder() =>
      new DailyIntakesLightReportBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyIntakesLightReport &&
        date == other.date &&
        nutrientNormsAndTotals == other.nutrientNormsAndTotals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, nutrientNormsAndTotals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyIntakesLightReport')
          ..add('date', date)
          ..add('nutrientNormsAndTotals', nutrientNormsAndTotals))
        .toString();
  }
}

class DailyIntakesLightReportBuilder
    implements
        Builder<DailyIntakesLightReport, DailyIntakesLightReportBuilder> {
  _$DailyIntakesLightReport? _$v;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  DailyNutrientNormsWithTotalsBuilder? _nutrientNormsAndTotals;
  DailyNutrientNormsWithTotalsBuilder get nutrientNormsAndTotals =>
      _$this._nutrientNormsAndTotals ??=
          new DailyNutrientNormsWithTotalsBuilder();
  set nutrientNormsAndTotals(
          DailyNutrientNormsWithTotalsBuilder? nutrientNormsAndTotals) =>
      _$this._nutrientNormsAndTotals = nutrientNormsAndTotals;

  DailyIntakesLightReportBuilder() {
    DailyIntakesLightReport._defaults(this);
  }

  DailyIntakesLightReportBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _nutrientNormsAndTotals = $v.nutrientNormsAndTotals.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyIntakesLightReport other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DailyIntakesLightReport;
  }

  @override
  void update(void Function(DailyIntakesLightReportBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyIntakesLightReport build() => _build();

  _$DailyIntakesLightReport _build() {
    _$DailyIntakesLightReport _$result;
    try {
      _$result = _$v ??
          new _$DailyIntakesLightReport._(
              date: BuiltValueNullFieldError.checkNotNull(
                  date, r'DailyIntakesLightReport', 'date'),
              nutrientNormsAndTotals: nutrientNormsAndTotals.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'nutrientNormsAndTotals';
        nutrientNormsAndTotals.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DailyIntakesLightReport', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
