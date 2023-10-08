// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pulse_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PulseRequest extends PulseRequest {
  @override
  final int pulse;
  @override
  final DateTime measuredAt;

  factory _$PulseRequest([void Function(PulseRequestBuilder)? updates]) =>
      (new PulseRequestBuilder()..update(updates))._build();

  _$PulseRequest._({required this.pulse, required this.measuredAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(pulse, r'PulseRequest', 'pulse');
    BuiltValueNullFieldError.checkNotNull(
        measuredAt, r'PulseRequest', 'measuredAt');
  }

  @override
  PulseRequest rebuild(void Function(PulseRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PulseRequestBuilder toBuilder() => new PulseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PulseRequest &&
        pulse == other.pulse &&
        measuredAt == other.measuredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pulse.hashCode);
    _$hash = $jc(_$hash, measuredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PulseRequest')
          ..add('pulse', pulse)
          ..add('measuredAt', measuredAt))
        .toString();
  }
}

class PulseRequestBuilder
    implements Builder<PulseRequest, PulseRequestBuilder> {
  _$PulseRequest? _$v;

  int? _pulse;
  int? get pulse => _$this._pulse;
  set pulse(int? pulse) => _$this._pulse = pulse;

  DateTime? _measuredAt;
  DateTime? get measuredAt => _$this._measuredAt;
  set measuredAt(DateTime? measuredAt) => _$this._measuredAt = measuredAt;

  PulseRequestBuilder() {
    PulseRequest._defaults(this);
  }

  PulseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pulse = $v.pulse;
      _measuredAt = $v.measuredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PulseRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PulseRequest;
  }

  @override
  void update(void Function(PulseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PulseRequest build() => _build();

  _$PulseRequest _build() {
    final _$result = _$v ??
        new _$PulseRequest._(
            pulse: BuiltValueNullFieldError.checkNotNull(
                pulse, r'PulseRequest', 'pulse'),
            measuredAt: BuiltValueNullFieldError.checkNotNull(
                measuredAt, r'PulseRequest', 'measuredAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
