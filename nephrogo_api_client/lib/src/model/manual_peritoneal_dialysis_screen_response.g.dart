// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_peritoneal_dialysis_screen_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ManualPeritonealDialysisScreenResponse
    extends ManualPeritonealDialysisScreenResponse {
  @override
  final ManualPeritonealDialysis? peritonealDialysisInProgress;
  @override
  final BuiltList<ManualPeritonealDialysis> lastPeritonealDialysis;
  @override
  final BuiltList<DailyIntakesLightReport> lastWeekLightNutritionReports;
  @override
  final BuiltList<DailyHealthStatus> lastWeekHealthStatuses;

  factory _$ManualPeritonealDialysisScreenResponse(
          [void Function(ManualPeritonealDialysisScreenResponseBuilder)?
              updates]) =>
      (new ManualPeritonealDialysisScreenResponseBuilder()..update(updates))
          ._build();

  _$ManualPeritonealDialysisScreenResponse._(
      {this.peritonealDialysisInProgress,
      required this.lastPeritonealDialysis,
      required this.lastWeekLightNutritionReports,
      required this.lastWeekHealthStatuses})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(lastPeritonealDialysis,
        r'ManualPeritonealDialysisScreenResponse', 'lastPeritonealDialysis');
    BuiltValueNullFieldError.checkNotNull(
        lastWeekLightNutritionReports,
        r'ManualPeritonealDialysisScreenResponse',
        'lastWeekLightNutritionReports');
    BuiltValueNullFieldError.checkNotNull(lastWeekHealthStatuses,
        r'ManualPeritonealDialysisScreenResponse', 'lastWeekHealthStatuses');
  }

  @override
  ManualPeritonealDialysisScreenResponse rebuild(
          void Function(ManualPeritonealDialysisScreenResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ManualPeritonealDialysisScreenResponseBuilder toBuilder() =>
      new ManualPeritonealDialysisScreenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ManualPeritonealDialysisScreenResponse &&
        peritonealDialysisInProgress == other.peritonealDialysisInProgress &&
        lastPeritonealDialysis == other.lastPeritonealDialysis &&
        lastWeekLightNutritionReports == other.lastWeekLightNutritionReports &&
        lastWeekHealthStatuses == other.lastWeekHealthStatuses;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, peritonealDialysisInProgress.hashCode);
    _$hash = $jc(_$hash, lastPeritonealDialysis.hashCode);
    _$hash = $jc(_$hash, lastWeekLightNutritionReports.hashCode);
    _$hash = $jc(_$hash, lastWeekHealthStatuses.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ManualPeritonealDialysisScreenResponse')
          ..add('peritonealDialysisInProgress', peritonealDialysisInProgress)
          ..add('lastPeritonealDialysis', lastPeritonealDialysis)
          ..add('lastWeekLightNutritionReports', lastWeekLightNutritionReports)
          ..add('lastWeekHealthStatuses', lastWeekHealthStatuses))
        .toString();
  }
}

class ManualPeritonealDialysisScreenResponseBuilder
    implements
        Builder<ManualPeritonealDialysisScreenResponse,
            ManualPeritonealDialysisScreenResponseBuilder> {
  _$ManualPeritonealDialysisScreenResponse? _$v;

  ManualPeritonealDialysisBuilder? _peritonealDialysisInProgress;
  ManualPeritonealDialysisBuilder get peritonealDialysisInProgress =>
      _$this._peritonealDialysisInProgress ??=
          new ManualPeritonealDialysisBuilder();
  set peritonealDialysisInProgress(
          ManualPeritonealDialysisBuilder? peritonealDialysisInProgress) =>
      _$this._peritonealDialysisInProgress = peritonealDialysisInProgress;

  ListBuilder<ManualPeritonealDialysis>? _lastPeritonealDialysis;
  ListBuilder<ManualPeritonealDialysis> get lastPeritonealDialysis =>
      _$this._lastPeritonealDialysis ??=
          new ListBuilder<ManualPeritonealDialysis>();
  set lastPeritonealDialysis(
          ListBuilder<ManualPeritonealDialysis>? lastPeritonealDialysis) =>
      _$this._lastPeritonealDialysis = lastPeritonealDialysis;

  ListBuilder<DailyIntakesLightReport>? _lastWeekLightNutritionReports;
  ListBuilder<DailyIntakesLightReport> get lastWeekLightNutritionReports =>
      _$this._lastWeekLightNutritionReports ??=
          new ListBuilder<DailyIntakesLightReport>();
  set lastWeekLightNutritionReports(
          ListBuilder<DailyIntakesLightReport>?
              lastWeekLightNutritionReports) =>
      _$this._lastWeekLightNutritionReports = lastWeekLightNutritionReports;

  ListBuilder<DailyHealthStatus>? _lastWeekHealthStatuses;
  ListBuilder<DailyHealthStatus> get lastWeekHealthStatuses =>
      _$this._lastWeekHealthStatuses ??= new ListBuilder<DailyHealthStatus>();
  set lastWeekHealthStatuses(
          ListBuilder<DailyHealthStatus>? lastWeekHealthStatuses) =>
      _$this._lastWeekHealthStatuses = lastWeekHealthStatuses;

  ManualPeritonealDialysisScreenResponseBuilder() {
    ManualPeritonealDialysisScreenResponse._defaults(this);
  }

  ManualPeritonealDialysisScreenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _peritonealDialysisInProgress =
          $v.peritonealDialysisInProgress?.toBuilder();
      _lastPeritonealDialysis = $v.lastPeritonealDialysis.toBuilder();
      _lastWeekLightNutritionReports =
          $v.lastWeekLightNutritionReports.toBuilder();
      _lastWeekHealthStatuses = $v.lastWeekHealthStatuses.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ManualPeritonealDialysisScreenResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ManualPeritonealDialysisScreenResponse;
  }

  @override
  void update(
      void Function(ManualPeritonealDialysisScreenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ManualPeritonealDialysisScreenResponse build() => _build();

  _$ManualPeritonealDialysisScreenResponse _build() {
    _$ManualPeritonealDialysisScreenResponse _$result;
    try {
      _$result = _$v ??
          new _$ManualPeritonealDialysisScreenResponse._(
              peritonealDialysisInProgress:
                  _peritonealDialysisInProgress?.build(),
              lastPeritonealDialysis: lastPeritonealDialysis.build(),
              lastWeekLightNutritionReports:
                  lastWeekLightNutritionReports.build(),
              lastWeekHealthStatuses: lastWeekHealthStatuses.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'peritonealDialysisInProgress';
        _peritonealDialysisInProgress?.build();
        _$failedField = 'lastPeritonealDialysis';
        lastPeritonealDialysis.build();
        _$failedField = 'lastWeekLightNutritionReports';
        lastWeekLightNutritionReports.build();
        _$failedField = 'lastWeekHealthStatuses';
        lastWeekHealthStatuses.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ManualPeritonealDialysisScreenResponse',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
