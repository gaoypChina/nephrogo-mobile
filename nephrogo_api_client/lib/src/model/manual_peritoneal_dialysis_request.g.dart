// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_peritoneal_dialysis_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ManualPeritonealDialysisRequest
    extends ManualPeritonealDialysisRequest {
  @override
  final DateTime startedAt;
  @override
  final int solutionInMl;
  @override
  final bool? isCompleted;
  @override
  final DialysisSolutionEnum? dialysisSolution;
  @override
  final int? solutionOutMl;
  @override
  final DialysateColorEnum? dialysateColor;
  @override
  final String? notes;

  factory _$ManualPeritonealDialysisRequest(
          [void Function(ManualPeritonealDialysisRequestBuilder)? updates]) =>
      (new ManualPeritonealDialysisRequestBuilder()..update(updates))._build();

  _$ManualPeritonealDialysisRequest._(
      {required this.startedAt,
      required this.solutionInMl,
      this.isCompleted,
      this.dialysisSolution,
      this.solutionOutMl,
      this.dialysateColor,
      this.notes})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        startedAt, r'ManualPeritonealDialysisRequest', 'startedAt');
    BuiltValueNullFieldError.checkNotNull(
        solutionInMl, r'ManualPeritonealDialysisRequest', 'solutionInMl');
  }

  @override
  ManualPeritonealDialysisRequest rebuild(
          void Function(ManualPeritonealDialysisRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ManualPeritonealDialysisRequestBuilder toBuilder() =>
      new ManualPeritonealDialysisRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ManualPeritonealDialysisRequest &&
        startedAt == other.startedAt &&
        solutionInMl == other.solutionInMl &&
        isCompleted == other.isCompleted &&
        dialysisSolution == other.dialysisSolution &&
        solutionOutMl == other.solutionOutMl &&
        dialysateColor == other.dialysateColor &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, solutionInMl.hashCode);
    _$hash = $jc(_$hash, isCompleted.hashCode);
    _$hash = $jc(_$hash, dialysisSolution.hashCode);
    _$hash = $jc(_$hash, solutionOutMl.hashCode);
    _$hash = $jc(_$hash, dialysateColor.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ManualPeritonealDialysisRequest')
          ..add('startedAt', startedAt)
          ..add('solutionInMl', solutionInMl)
          ..add('isCompleted', isCompleted)
          ..add('dialysisSolution', dialysisSolution)
          ..add('solutionOutMl', solutionOutMl)
          ..add('dialysateColor', dialysateColor)
          ..add('notes', notes))
        .toString();
  }
}

class ManualPeritonealDialysisRequestBuilder
    implements
        Builder<ManualPeritonealDialysisRequest,
            ManualPeritonealDialysisRequestBuilder> {
  _$ManualPeritonealDialysisRequest? _$v;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  int? _solutionInMl;
  int? get solutionInMl => _$this._solutionInMl;
  set solutionInMl(int? solutionInMl) => _$this._solutionInMl = solutionInMl;

  bool? _isCompleted;
  bool? get isCompleted => _$this._isCompleted;
  set isCompleted(bool? isCompleted) => _$this._isCompleted = isCompleted;

  DialysisSolutionEnum? _dialysisSolution;
  DialysisSolutionEnum? get dialysisSolution => _$this._dialysisSolution;
  set dialysisSolution(DialysisSolutionEnum? dialysisSolution) =>
      _$this._dialysisSolution = dialysisSolution;

  int? _solutionOutMl;
  int? get solutionOutMl => _$this._solutionOutMl;
  set solutionOutMl(int? solutionOutMl) =>
      _$this._solutionOutMl = solutionOutMl;

  DialysateColorEnum? _dialysateColor;
  DialysateColorEnum? get dialysateColor => _$this._dialysateColor;
  set dialysateColor(DialysateColorEnum? dialysateColor) =>
      _$this._dialysateColor = dialysateColor;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  ManualPeritonealDialysisRequestBuilder() {
    ManualPeritonealDialysisRequest._defaults(this);
  }

  ManualPeritonealDialysisRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startedAt = $v.startedAt;
      _solutionInMl = $v.solutionInMl;
      _isCompleted = $v.isCompleted;
      _dialysisSolution = $v.dialysisSolution;
      _solutionOutMl = $v.solutionOutMl;
      _dialysateColor = $v.dialysateColor;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ManualPeritonealDialysisRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ManualPeritonealDialysisRequest;
  }

  @override
  void update(void Function(ManualPeritonealDialysisRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ManualPeritonealDialysisRequest build() => _build();

  _$ManualPeritonealDialysisRequest _build() {
    final _$result = _$v ??
        new _$ManualPeritonealDialysisRequest._(
            startedAt: BuiltValueNullFieldError.checkNotNull(
                startedAt, r'ManualPeritonealDialysisRequest', 'startedAt'),
            solutionInMl: BuiltValueNullFieldError.checkNotNull(solutionInMl,
                r'ManualPeritonealDialysisRequest', 'solutionInMl'),
            isCompleted: isCompleted,
            dialysisSolution: dialysisSolution,
            solutionOutMl: solutionOutMl,
            dialysateColor: dialysateColor,
            notes: notes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
