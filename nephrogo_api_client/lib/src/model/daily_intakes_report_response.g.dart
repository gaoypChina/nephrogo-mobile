// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_intakes_report_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyIntakesReportResponse extends DailyIntakesReportResponse {
  @override
  final DailyIntakesReport dailyIntakesReport;

  factory _$DailyIntakesReportResponse(
          [void Function(DailyIntakesReportResponseBuilder)? updates]) =>
      (new DailyIntakesReportResponseBuilder()..update(updates))._build();

  _$DailyIntakesReportResponse._({required this.dailyIntakesReport})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(dailyIntakesReport,
        r'DailyIntakesReportResponse', 'dailyIntakesReport');
  }

  @override
  DailyIntakesReportResponse rebuild(
          void Function(DailyIntakesReportResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyIntakesReportResponseBuilder toBuilder() =>
      new DailyIntakesReportResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyIntakesReportResponse &&
        dailyIntakesReport == other.dailyIntakesReport;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dailyIntakesReport.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyIntakesReportResponse')
          ..add('dailyIntakesReport', dailyIntakesReport))
        .toString();
  }
}

class DailyIntakesReportResponseBuilder
    implements
        Builder<DailyIntakesReportResponse, DailyIntakesReportResponseBuilder> {
  _$DailyIntakesReportResponse? _$v;

  DailyIntakesReportBuilder? _dailyIntakesReport;
  DailyIntakesReportBuilder get dailyIntakesReport =>
      _$this._dailyIntakesReport ??= new DailyIntakesReportBuilder();
  set dailyIntakesReport(DailyIntakesReportBuilder? dailyIntakesReport) =>
      _$this._dailyIntakesReport = dailyIntakesReport;

  DailyIntakesReportResponseBuilder() {
    DailyIntakesReportResponse._defaults(this);
  }

  DailyIntakesReportResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dailyIntakesReport = $v.dailyIntakesReport.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyIntakesReportResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DailyIntakesReportResponse;
  }

  @override
  void update(void Function(DailyIntakesReportResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyIntakesReportResponse build() => _build();

  _$DailyIntakesReportResponse _build() {
    _$DailyIntakesReportResponse _$result;
    try {
      _$result = _$v ??
          new _$DailyIntakesReportResponse._(
              dailyIntakesReport: dailyIntakesReport.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dailyIntakesReport';
        dailyIntakesReport.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DailyIntakesReportResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
