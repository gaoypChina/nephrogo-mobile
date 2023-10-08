// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_intakes_reports_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyIntakesReportsResponse extends DailyIntakesReportsResponse {
  @override
  final BuiltList<DailyIntakesLightReport> dailyIntakesLightReports;

  factory _$DailyIntakesReportsResponse(
          [void Function(DailyIntakesReportsResponseBuilder)? updates]) =>
      (new DailyIntakesReportsResponseBuilder()..update(updates))._build();

  _$DailyIntakesReportsResponse._({required this.dailyIntakesLightReports})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(dailyIntakesLightReports,
        r'DailyIntakesReportsResponse', 'dailyIntakesLightReports');
  }

  @override
  DailyIntakesReportsResponse rebuild(
          void Function(DailyIntakesReportsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyIntakesReportsResponseBuilder toBuilder() =>
      new DailyIntakesReportsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyIntakesReportsResponse &&
        dailyIntakesLightReports == other.dailyIntakesLightReports;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dailyIntakesLightReports.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyIntakesReportsResponse')
          ..add('dailyIntakesLightReports', dailyIntakesLightReports))
        .toString();
  }
}

class DailyIntakesReportsResponseBuilder
    implements
        Builder<DailyIntakesReportsResponse,
            DailyIntakesReportsResponseBuilder> {
  _$DailyIntakesReportsResponse? _$v;

  ListBuilder<DailyIntakesLightReport>? _dailyIntakesLightReports;
  ListBuilder<DailyIntakesLightReport> get dailyIntakesLightReports =>
      _$this._dailyIntakesLightReports ??=
          new ListBuilder<DailyIntakesLightReport>();
  set dailyIntakesLightReports(
          ListBuilder<DailyIntakesLightReport>? dailyIntakesLightReports) =>
      _$this._dailyIntakesLightReports = dailyIntakesLightReports;

  DailyIntakesReportsResponseBuilder() {
    DailyIntakesReportsResponse._defaults(this);
  }

  DailyIntakesReportsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dailyIntakesLightReports = $v.dailyIntakesLightReports.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyIntakesReportsResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DailyIntakesReportsResponse;
  }

  @override
  void update(void Function(DailyIntakesReportsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyIntakesReportsResponse build() => _build();

  _$DailyIntakesReportsResponse _build() {
    _$DailyIntakesReportsResponse _$result;
    try {
      _$result = _$v ??
          new _$DailyIntakesReportsResponse._(
              dailyIntakesLightReports: dailyIntakesLightReports.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dailyIntakesLightReports';
        dailyIntakesLightReports.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DailyIntakesReportsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
