// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pulse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Pulse extends Pulse {
  @override
  final int id;
  @override
  final int pulse;
  @override
  final DateTime measuredAt;

  factory _$Pulse([void Function(PulseBuilder)? updates]) =>
      (new PulseBuilder()..update(updates))._build();

  _$Pulse._({required this.id, required this.pulse, required this.measuredAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Pulse', 'id');
    BuiltValueNullFieldError.checkNotNull(pulse, r'Pulse', 'pulse');
    BuiltValueNullFieldError.checkNotNull(measuredAt, r'Pulse', 'measuredAt');
  }

  @override
  Pulse rebuild(void Function(PulseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PulseBuilder toBuilder() => new PulseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Pulse &&
        id == other.id &&
        pulse == other.pulse &&
        measuredAt == other.measuredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, pulse.hashCode);
    _$hash = $jc(_$hash, measuredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Pulse')
          ..add('id', id)
          ..add('pulse', pulse)
          ..add('measuredAt', measuredAt))
        .toString();
  }
}

class PulseBuilder implements Builder<Pulse, PulseBuilder> {
  _$Pulse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _pulse;
  int? get pulse => _$this._pulse;
  set pulse(int? pulse) => _$this._pulse = pulse;

  DateTime? _measuredAt;
  DateTime? get measuredAt => _$this._measuredAt;
  set measuredAt(DateTime? measuredAt) => _$this._measuredAt = measuredAt;

  PulseBuilder() {
    Pulse._defaults(this);
  }

  PulseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _pulse = $v.pulse;
      _measuredAt = $v.measuredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Pulse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Pulse;
  }

  @override
  void update(void Function(PulseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Pulse build() => _build();

  _$Pulse _build() {
    final _$result = _$v ??
        new _$Pulse._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Pulse', 'id'),
            pulse:
                BuiltValueNullFieldError.checkNotNull(pulse, r'Pulse', 'pulse'),
            measuredAt: BuiltValueNullFieldError.checkNotNull(
                measuredAt, r'Pulse', 'measuredAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
