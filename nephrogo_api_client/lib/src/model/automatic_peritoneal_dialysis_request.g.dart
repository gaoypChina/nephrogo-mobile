// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automatic_peritoneal_dialysis_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AutomaticPeritonealDialysisRequest
    extends AutomaticPeritonealDialysisRequest {
  @override
  final DateTime startedAt;
  @override
  final bool? isCompleted;
  @override
  final int? solutionGreenInMl;
  @override
  final int? solutionYellowInMl;
  @override
  final int? solutionOrangeInMl;
  @override
  final int? solutionBlueInMl;
  @override
  final int? solutionPurpleInMl;
  @override
  final int? initialDrainingMl;
  @override
  final int? totalDrainVolumeMl;
  @override
  final int? lastFillMl;
  @override
  final int? totalUltrafiltrationMl;
  @override
  final DialysateColorEnum? dialysateColor;
  @override
  final String? notes;
  @override
  final DateTime? finishedAt;

  factory _$AutomaticPeritonealDialysisRequest(
          [void Function(AutomaticPeritonealDialysisRequestBuilder)?
              updates]) =>
      (new AutomaticPeritonealDialysisRequestBuilder()..update(updates))
          ._build();

  _$AutomaticPeritonealDialysisRequest._(
      {required this.startedAt,
      this.isCompleted,
      this.solutionGreenInMl,
      this.solutionYellowInMl,
      this.solutionOrangeInMl,
      this.solutionBlueInMl,
      this.solutionPurpleInMl,
      this.initialDrainingMl,
      this.totalDrainVolumeMl,
      this.lastFillMl,
      this.totalUltrafiltrationMl,
      this.dialysateColor,
      this.notes,
      this.finishedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        startedAt, r'AutomaticPeritonealDialysisRequest', 'startedAt');
  }

  @override
  AutomaticPeritonealDialysisRequest rebuild(
          void Function(AutomaticPeritonealDialysisRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AutomaticPeritonealDialysisRequestBuilder toBuilder() =>
      new AutomaticPeritonealDialysisRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AutomaticPeritonealDialysisRequest &&
        startedAt == other.startedAt &&
        isCompleted == other.isCompleted &&
        solutionGreenInMl == other.solutionGreenInMl &&
        solutionYellowInMl == other.solutionYellowInMl &&
        solutionOrangeInMl == other.solutionOrangeInMl &&
        solutionBlueInMl == other.solutionBlueInMl &&
        solutionPurpleInMl == other.solutionPurpleInMl &&
        initialDrainingMl == other.initialDrainingMl &&
        totalDrainVolumeMl == other.totalDrainVolumeMl &&
        lastFillMl == other.lastFillMl &&
        totalUltrafiltrationMl == other.totalUltrafiltrationMl &&
        dialysateColor == other.dialysateColor &&
        notes == other.notes &&
        finishedAt == other.finishedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, isCompleted.hashCode);
    _$hash = $jc(_$hash, solutionGreenInMl.hashCode);
    _$hash = $jc(_$hash, solutionYellowInMl.hashCode);
    _$hash = $jc(_$hash, solutionOrangeInMl.hashCode);
    _$hash = $jc(_$hash, solutionBlueInMl.hashCode);
    _$hash = $jc(_$hash, solutionPurpleInMl.hashCode);
    _$hash = $jc(_$hash, initialDrainingMl.hashCode);
    _$hash = $jc(_$hash, totalDrainVolumeMl.hashCode);
    _$hash = $jc(_$hash, lastFillMl.hashCode);
    _$hash = $jc(_$hash, totalUltrafiltrationMl.hashCode);
    _$hash = $jc(_$hash, dialysateColor.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, finishedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AutomaticPeritonealDialysisRequest')
          ..add('startedAt', startedAt)
          ..add('isCompleted', isCompleted)
          ..add('solutionGreenInMl', solutionGreenInMl)
          ..add('solutionYellowInMl', solutionYellowInMl)
          ..add('solutionOrangeInMl', solutionOrangeInMl)
          ..add('solutionBlueInMl', solutionBlueInMl)
          ..add('solutionPurpleInMl', solutionPurpleInMl)
          ..add('initialDrainingMl', initialDrainingMl)
          ..add('totalDrainVolumeMl', totalDrainVolumeMl)
          ..add('lastFillMl', lastFillMl)
          ..add('totalUltrafiltrationMl', totalUltrafiltrationMl)
          ..add('dialysateColor', dialysateColor)
          ..add('notes', notes)
          ..add('finishedAt', finishedAt))
        .toString();
  }
}

class AutomaticPeritonealDialysisRequestBuilder
    implements
        Builder<AutomaticPeritonealDialysisRequest,
            AutomaticPeritonealDialysisRequestBuilder> {
  _$AutomaticPeritonealDialysisRequest? _$v;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  bool? _isCompleted;
  bool? get isCompleted => _$this._isCompleted;
  set isCompleted(bool? isCompleted) => _$this._isCompleted = isCompleted;

  int? _solutionGreenInMl;
  int? get solutionGreenInMl => _$this._solutionGreenInMl;
  set solutionGreenInMl(int? solutionGreenInMl) =>
      _$this._solutionGreenInMl = solutionGreenInMl;

  int? _solutionYellowInMl;
  int? get solutionYellowInMl => _$this._solutionYellowInMl;
  set solutionYellowInMl(int? solutionYellowInMl) =>
      _$this._solutionYellowInMl = solutionYellowInMl;

  int? _solutionOrangeInMl;
  int? get solutionOrangeInMl => _$this._solutionOrangeInMl;
  set solutionOrangeInMl(int? solutionOrangeInMl) =>
      _$this._solutionOrangeInMl = solutionOrangeInMl;

  int? _solutionBlueInMl;
  int? get solutionBlueInMl => _$this._solutionBlueInMl;
  set solutionBlueInMl(int? solutionBlueInMl) =>
      _$this._solutionBlueInMl = solutionBlueInMl;

  int? _solutionPurpleInMl;
  int? get solutionPurpleInMl => _$this._solutionPurpleInMl;
  set solutionPurpleInMl(int? solutionPurpleInMl) =>
      _$this._solutionPurpleInMl = solutionPurpleInMl;

  int? _initialDrainingMl;
  int? get initialDrainingMl => _$this._initialDrainingMl;
  set initialDrainingMl(int? initialDrainingMl) =>
      _$this._initialDrainingMl = initialDrainingMl;

  int? _totalDrainVolumeMl;
  int? get totalDrainVolumeMl => _$this._totalDrainVolumeMl;
  set totalDrainVolumeMl(int? totalDrainVolumeMl) =>
      _$this._totalDrainVolumeMl = totalDrainVolumeMl;

  int? _lastFillMl;
  int? get lastFillMl => _$this._lastFillMl;
  set lastFillMl(int? lastFillMl) => _$this._lastFillMl = lastFillMl;

  int? _totalUltrafiltrationMl;
  int? get totalUltrafiltrationMl => _$this._totalUltrafiltrationMl;
  set totalUltrafiltrationMl(int? totalUltrafiltrationMl) =>
      _$this._totalUltrafiltrationMl = totalUltrafiltrationMl;

  DialysateColorEnum? _dialysateColor;
  DialysateColorEnum? get dialysateColor => _$this._dialysateColor;
  set dialysateColor(DialysateColorEnum? dialysateColor) =>
      _$this._dialysateColor = dialysateColor;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  DateTime? _finishedAt;
  DateTime? get finishedAt => _$this._finishedAt;
  set finishedAt(DateTime? finishedAt) => _$this._finishedAt = finishedAt;

  AutomaticPeritonealDialysisRequestBuilder() {
    AutomaticPeritonealDialysisRequest._defaults(this);
  }

  AutomaticPeritonealDialysisRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startedAt = $v.startedAt;
      _isCompleted = $v.isCompleted;
      _solutionGreenInMl = $v.solutionGreenInMl;
      _solutionYellowInMl = $v.solutionYellowInMl;
      _solutionOrangeInMl = $v.solutionOrangeInMl;
      _solutionBlueInMl = $v.solutionBlueInMl;
      _solutionPurpleInMl = $v.solutionPurpleInMl;
      _initialDrainingMl = $v.initialDrainingMl;
      _totalDrainVolumeMl = $v.totalDrainVolumeMl;
      _lastFillMl = $v.lastFillMl;
      _totalUltrafiltrationMl = $v.totalUltrafiltrationMl;
      _dialysateColor = $v.dialysateColor;
      _notes = $v.notes;
      _finishedAt = $v.finishedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AutomaticPeritonealDialysisRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AutomaticPeritonealDialysisRequest;
  }

  @override
  void update(
      void Function(AutomaticPeritonealDialysisRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AutomaticPeritonealDialysisRequest build() => _build();

  _$AutomaticPeritonealDialysisRequest _build() {
    final _$result = _$v ??
        new _$AutomaticPeritonealDialysisRequest._(
            startedAt: BuiltValueNullFieldError.checkNotNull(
                startedAt, r'AutomaticPeritonealDialysisRequest', 'startedAt'),
            isCompleted: isCompleted,
            solutionGreenInMl: solutionGreenInMl,
            solutionYellowInMl: solutionYellowInMl,
            solutionOrangeInMl: solutionOrangeInMl,
            solutionBlueInMl: solutionBlueInMl,
            solutionPurpleInMl: solutionPurpleInMl,
            initialDrainingMl: initialDrainingMl,
            totalDrainVolumeMl: totalDrainVolumeMl,
            lastFillMl: lastFillMl,
            totalUltrafiltrationMl: totalUltrafiltrationMl,
            dialysateColor: dialysateColor,
            notes: notes,
            finishedAt: finishedAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
