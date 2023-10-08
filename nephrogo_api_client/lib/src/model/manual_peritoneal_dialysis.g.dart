// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_peritoneal_dialysis.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ManualPeritonealDialysis extends ManualPeritonealDialysis {
  @override
  final int id;
  @override
  final DateTime startedAt;
  @override
  final int solutionInMl;
  @override
  final DateTime? finishedAt;
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

  factory _$ManualPeritonealDialysis(
          [void Function(ManualPeritonealDialysisBuilder)? updates]) =>
      (new ManualPeritonealDialysisBuilder()..update(updates))._build();

  _$ManualPeritonealDialysis._(
      {required this.id,
      required this.startedAt,
      required this.solutionInMl,
      this.finishedAt,
      this.isCompleted,
      this.dialysisSolution,
      this.solutionOutMl,
      this.dialysateColor,
      this.notes})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'ManualPeritonealDialysis', 'id');
    BuiltValueNullFieldError.checkNotNull(
        startedAt, r'ManualPeritonealDialysis', 'startedAt');
    BuiltValueNullFieldError.checkNotNull(
        solutionInMl, r'ManualPeritonealDialysis', 'solutionInMl');
  }

  @override
  ManualPeritonealDialysis rebuild(
          void Function(ManualPeritonealDialysisBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ManualPeritonealDialysisBuilder toBuilder() =>
      new ManualPeritonealDialysisBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ManualPeritonealDialysis &&
        id == other.id &&
        startedAt == other.startedAt &&
        solutionInMl == other.solutionInMl &&
        finishedAt == other.finishedAt &&
        isCompleted == other.isCompleted &&
        dialysisSolution == other.dialysisSolution &&
        solutionOutMl == other.solutionOutMl &&
        dialysateColor == other.dialysateColor &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, solutionInMl.hashCode);
    _$hash = $jc(_$hash, finishedAt.hashCode);
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
    return (newBuiltValueToStringHelper(r'ManualPeritonealDialysis')
          ..add('id', id)
          ..add('startedAt', startedAt)
          ..add('solutionInMl', solutionInMl)
          ..add('finishedAt', finishedAt)
          ..add('isCompleted', isCompleted)
          ..add('dialysisSolution', dialysisSolution)
          ..add('solutionOutMl', solutionOutMl)
          ..add('dialysateColor', dialysateColor)
          ..add('notes', notes))
        .toString();
  }
}

class ManualPeritonealDialysisBuilder
    implements
        Builder<ManualPeritonealDialysis, ManualPeritonealDialysisBuilder> {
  _$ManualPeritonealDialysis? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  int? _solutionInMl;
  int? get solutionInMl => _$this._solutionInMl;
  set solutionInMl(int? solutionInMl) => _$this._solutionInMl = solutionInMl;

  DateTime? _finishedAt;
  DateTime? get finishedAt => _$this._finishedAt;
  set finishedAt(DateTime? finishedAt) => _$this._finishedAt = finishedAt;

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

  ManualPeritonealDialysisBuilder() {
    ManualPeritonealDialysis._defaults(this);
  }

  ManualPeritonealDialysisBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _startedAt = $v.startedAt;
      _solutionInMl = $v.solutionInMl;
      _finishedAt = $v.finishedAt;
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
  void replace(ManualPeritonealDialysis other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ManualPeritonealDialysis;
  }

  @override
  void update(void Function(ManualPeritonealDialysisBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ManualPeritonealDialysis build() => _build();

  _$ManualPeritonealDialysis _build() {
    final _$result = _$v ??
        new _$ManualPeritonealDialysis._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'ManualPeritonealDialysis', 'id'),
            startedAt: BuiltValueNullFieldError.checkNotNull(
                startedAt, r'ManualPeritonealDialysis', 'startedAt'),
            solutionInMl: BuiltValueNullFieldError.checkNotNull(
                solutionInMl, r'ManualPeritonealDialysis', 'solutionInMl'),
            finishedAt: finishedAt,
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
