// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automatic_peritoneal_dialysis_screen_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AutomaticPeritonealDialysisScreenResponse
    extends AutomaticPeritonealDialysisScreenResponse {
  @override
  final AutomaticPeritonealDialysis? lastPeritonealDialysis;
  @override
  final BuiltList<DailyHealthStatus> lastWeekHealthStatuses;
  @override
  final BuiltList<DailyIntakesLightReport> lastWeekLightNutritionReports;
  @override
  final AutomaticPeritonealDialysis? peritonealDialysisInProgress;

  factory _$AutomaticPeritonealDialysisScreenResponse(
          [void Function(AutomaticPeritonealDialysisScreenResponseBuilder)?
              updates]) =>
      (new AutomaticPeritonealDialysisScreenResponseBuilder()..update(updates))
          ._build();

  _$AutomaticPeritonealDialysisScreenResponse._(
      {this.lastPeritonealDialysis,
      required this.lastWeekHealthStatuses,
      required this.lastWeekLightNutritionReports,
      this.peritonealDialysisInProgress})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(lastWeekHealthStatuses,
        r'AutomaticPeritonealDialysisScreenResponse', 'lastWeekHealthStatuses');
    BuiltValueNullFieldError.checkNotNull(
        lastWeekLightNutritionReports,
        r'AutomaticPeritonealDialysisScreenResponse',
        'lastWeekLightNutritionReports');
  }

  @override
  AutomaticPeritonealDialysisScreenResponse rebuild(
          void Function(AutomaticPeritonealDialysisScreenResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AutomaticPeritonealDialysisScreenResponseBuilder toBuilder() =>
      new AutomaticPeritonealDialysisScreenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AutomaticPeritonealDialysisScreenResponse &&
        lastPeritonealDialysis == other.lastPeritonealDialysis &&
        lastWeekHealthStatuses == other.lastWeekHealthStatuses &&
        lastWeekLightNutritionReports == other.lastWeekLightNutritionReports &&
        peritonealDialysisInProgress == other.peritonealDialysisInProgress;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, lastPeritonealDialysis.hashCode);
    _$hash = $jc(_$hash, lastWeekHealthStatuses.hashCode);
    _$hash = $jc(_$hash, lastWeekLightNutritionReports.hashCode);
    _$hash = $jc(_$hash, peritonealDialysisInProgress.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AutomaticPeritonealDialysisScreenResponse')
          ..add('lastPeritonealDialysis', lastPeritonealDialysis)
          ..add('lastWeekHealthStatuses', lastWeekHealthStatuses)
          ..add('lastWeekLightNutritionReports', lastWeekLightNutritionReports)
          ..add('peritonealDialysisInProgress', peritonealDialysisInProgress))
        .toString();
  }
}

class AutomaticPeritonealDialysisScreenResponseBuilder
    implements
        Builder<AutomaticPeritonealDialysisScreenResponse,
            AutomaticPeritonealDialysisScreenResponseBuilder> {
  _$AutomaticPeritonealDialysisScreenResponse? _$v;

  AutomaticPeritonealDialysisBuilder? _lastPeritonealDialysis;
  AutomaticPeritonealDialysisBuilder get lastPeritonealDialysis =>
      _$this._lastPeritonealDialysis ??=
          new AutomaticPeritonealDialysisBuilder();
  set lastPeritonealDialysis(
          AutomaticPeritonealDialysisBuilder? lastPeritonealDialysis) =>
      _$this._lastPeritonealDialysis = lastPeritonealDialysis;

  ListBuilder<DailyHealthStatus>? _lastWeekHealthStatuses;
  ListBuilder<DailyHealthStatus> get lastWeekHealthStatuses =>
      _$this._lastWeekHealthStatuses ??= new ListBuilder<DailyHealthStatus>();
  set lastWeekHealthStatuses(
          ListBuilder<DailyHealthStatus>? lastWeekHealthStatuses) =>
      _$this._lastWeekHealthStatuses = lastWeekHealthStatuses;

  ListBuilder<DailyIntakesLightReport>? _lastWeekLightNutritionReports;
  ListBuilder<DailyIntakesLightReport> get lastWeekLightNutritionReports =>
      _$this._lastWeekLightNutritionReports ??=
          new ListBuilder<DailyIntakesLightReport>();
  set lastWeekLightNutritionReports(
          ListBuilder<DailyIntakesLightReport>?
              lastWeekLightNutritionReports) =>
      _$this._lastWeekLightNutritionReports = lastWeekLightNutritionReports;

  AutomaticPeritonealDialysisBuilder? _peritonealDialysisInProgress;
  AutomaticPeritonealDialysisBuilder get peritonealDialysisInProgress =>
      _$this._peritonealDialysisInProgress ??=
          new AutomaticPeritonealDialysisBuilder();
  set peritonealDialysisInProgress(
          AutomaticPeritonealDialysisBuilder? peritonealDialysisInProgress) =>
      _$this._peritonealDialysisInProgress = peritonealDialysisInProgress;

  AutomaticPeritonealDialysisScreenResponseBuilder() {
    AutomaticPeritonealDialysisScreenResponse._defaults(this);
  }

  AutomaticPeritonealDialysisScreenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lastPeritonealDialysis = $v.lastPeritonealDialysis?.toBuilder();
      _lastWeekHealthStatuses = $v.lastWeekHealthStatuses.toBuilder();
      _lastWeekLightNutritionReports =
          $v.lastWeekLightNutritionReports.toBuilder();
      _peritonealDialysisInProgress =
          $v.peritonealDialysisInProgress?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AutomaticPeritonealDialysisScreenResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AutomaticPeritonealDialysisScreenResponse;
  }

  @override
  void update(
      void Function(AutomaticPeritonealDialysisScreenResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  AutomaticPeritonealDialysisScreenResponse build() => _build();

  _$AutomaticPeritonealDialysisScreenResponse _build() {
    _$AutomaticPeritonealDialysisScreenResponse _$result;
    try {
      _$result = _$v ??
          new _$AutomaticPeritonealDialysisScreenResponse._(
              lastPeritonealDialysis: _lastPeritonealDialysis?.build(),
              lastWeekHealthStatuses: lastWeekHealthStatuses.build(),
              lastWeekLightNutritionReports:
                  lastWeekLightNutritionReports.build(),
              peritonealDialysisInProgress:
                  _peritonealDialysisInProgress?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lastPeritonealDialysis';
        _lastPeritonealDialysis?.build();
        _$failedField = 'lastWeekHealthStatuses';
        lastWeekHealthStatuses.build();
        _$failedField = 'lastWeekLightNutritionReports';
        lastWeekLightNutritionReports.build();
        _$failedField = 'peritonealDialysisInProgress';
        _peritonealDialysisInProgress?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AutomaticPeritonealDialysisScreenResponse',
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
