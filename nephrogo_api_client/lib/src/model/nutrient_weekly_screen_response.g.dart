// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrient_weekly_screen_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NutrientWeeklyScreenResponse extends NutrientWeeklyScreenResponse {
  @override
  final Date? earliestReportDate;
  @override
  final BuiltList<DailyIntakesReport> dailyIntakesReports;

  factory _$NutrientWeeklyScreenResponse(
          [void Function(NutrientWeeklyScreenResponseBuilder)? updates]) =>
      (new NutrientWeeklyScreenResponseBuilder()..update(updates))._build();

  _$NutrientWeeklyScreenResponse._(
      {this.earliestReportDate, required this.dailyIntakesReports})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(dailyIntakesReports,
        r'NutrientWeeklyScreenResponse', 'dailyIntakesReports');
  }

  @override
  NutrientWeeklyScreenResponse rebuild(
          void Function(NutrientWeeklyScreenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NutrientWeeklyScreenResponseBuilder toBuilder() =>
      new NutrientWeeklyScreenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NutrientWeeklyScreenResponse &&
        earliestReportDate == other.earliestReportDate &&
        dailyIntakesReports == other.dailyIntakesReports;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, earliestReportDate.hashCode);
    _$hash = $jc(_$hash, dailyIntakesReports.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NutrientWeeklyScreenResponse')
          ..add('earliestReportDate', earliestReportDate)
          ..add('dailyIntakesReports', dailyIntakesReports))
        .toString();
  }
}

class NutrientWeeklyScreenResponseBuilder
    implements
        Builder<NutrientWeeklyScreenResponse,
            NutrientWeeklyScreenResponseBuilder> {
  _$NutrientWeeklyScreenResponse? _$v;

  Date? _earliestReportDate;
  Date? get earliestReportDate => _$this._earliestReportDate;
  set earliestReportDate(Date? earliestReportDate) =>
      _$this._earliestReportDate = earliestReportDate;

  ListBuilder<DailyIntakesReport>? _dailyIntakesReports;
  ListBuilder<DailyIntakesReport> get dailyIntakesReports =>
      _$this._dailyIntakesReports ??= new ListBuilder<DailyIntakesReport>();
  set dailyIntakesReports(
          ListBuilder<DailyIntakesReport>? dailyIntakesReports) =>
      _$this._dailyIntakesReports = dailyIntakesReports;

  NutrientWeeklyScreenResponseBuilder() {
    NutrientWeeklyScreenResponse._defaults(this);
  }

  NutrientWeeklyScreenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _earliestReportDate = $v.earliestReportDate;
      _dailyIntakesReports = $v.dailyIntakesReports.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NutrientWeeklyScreenResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NutrientWeeklyScreenResponse;
  }

  @override
  void update(void Function(NutrientWeeklyScreenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NutrientWeeklyScreenResponse build() => _build();

  _$NutrientWeeklyScreenResponse _build() {
    _$NutrientWeeklyScreenResponse _$result;
    try {
      _$result = _$v ??
          new _$NutrientWeeklyScreenResponse._(
              earliestReportDate: earliestReportDate,
              dailyIntakesReports: dailyIntakesReports.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dailyIntakesReports';
        dailyIntakesReports.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NutrientWeeklyScreenResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
