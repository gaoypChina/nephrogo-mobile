// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_intakes_report.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyIntakesReport extends DailyIntakesReport {
  @override
  final Date date;
  @override
  final BuiltList<Intake> intakes;
  @override
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;

  factory _$DailyIntakesReport(
          [void Function(DailyIntakesReportBuilder)? updates]) =>
      (new DailyIntakesReportBuilder()..update(updates))._build();

  _$DailyIntakesReport._(
      {required this.date,
      required this.intakes,
      required this.dailyNutrientNormsAndTotals})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(date, r'DailyIntakesReport', 'date');
    BuiltValueNullFieldError.checkNotNull(
        intakes, r'DailyIntakesReport', 'intakes');
    BuiltValueNullFieldError.checkNotNull(dailyNutrientNormsAndTotals,
        r'DailyIntakesReport', 'dailyNutrientNormsAndTotals');
  }

  @override
  DailyIntakesReport rebuild(
          void Function(DailyIntakesReportBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyIntakesReportBuilder toBuilder() =>
      new DailyIntakesReportBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyIntakesReport &&
        date == other.date &&
        intakes == other.intakes &&
        dailyNutrientNormsAndTotals == other.dailyNutrientNormsAndTotals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, intakes.hashCode);
    _$hash = $jc(_$hash, dailyNutrientNormsAndTotals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyIntakesReport')
          ..add('date', date)
          ..add('intakes', intakes)
          ..add('dailyNutrientNormsAndTotals', dailyNutrientNormsAndTotals))
        .toString();
  }
}

class DailyIntakesReportBuilder
    implements Builder<DailyIntakesReport, DailyIntakesReportBuilder> {
  _$DailyIntakesReport? _$v;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  ListBuilder<Intake>? _intakes;
  ListBuilder<Intake> get intakes =>
      _$this._intakes ??= new ListBuilder<Intake>();
  set intakes(ListBuilder<Intake>? intakes) => _$this._intakes = intakes;

  DailyNutrientNormsWithTotalsBuilder? _dailyNutrientNormsAndTotals;
  DailyNutrientNormsWithTotalsBuilder get dailyNutrientNormsAndTotals =>
      _$this._dailyNutrientNormsAndTotals ??=
          new DailyNutrientNormsWithTotalsBuilder();
  set dailyNutrientNormsAndTotals(
          DailyNutrientNormsWithTotalsBuilder? dailyNutrientNormsAndTotals) =>
      _$this._dailyNutrientNormsAndTotals = dailyNutrientNormsAndTotals;

  DailyIntakesReportBuilder() {
    DailyIntakesReport._defaults(this);
  }

  DailyIntakesReportBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _intakes = $v.intakes.toBuilder();
      _dailyNutrientNormsAndTotals = $v.dailyNutrientNormsAndTotals.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyIntakesReport other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DailyIntakesReport;
  }

  @override
  void update(void Function(DailyIntakesReportBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyIntakesReport build() => _build();

  _$DailyIntakesReport _build() {
    _$DailyIntakesReport _$result;
    try {
      _$result = _$v ??
          new _$DailyIntakesReport._(
              date: BuiltValueNullFieldError.checkNotNull(
                  date, r'DailyIntakesReport', 'date'),
              intakes: intakes.build(),
              dailyNutrientNormsAndTotals: dailyNutrientNormsAndTotals.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'intakes';
        intakes.build();
        _$failedField = 'dailyNutrientNormsAndTotals';
        dailyNutrientNormsAndTotals.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DailyIntakesReport', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
