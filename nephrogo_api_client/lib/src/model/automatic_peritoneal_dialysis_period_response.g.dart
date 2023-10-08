// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automatic_peritoneal_dialysis_period_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AutomaticPeritonealDialysisPeriodResponse
    extends AutomaticPeritonealDialysisPeriodResponse {
  @override
  final BuiltList<AutomaticPeritonealDialysis> peritonealDialysis;

  factory _$AutomaticPeritonealDialysisPeriodResponse(
          [void Function(AutomaticPeritonealDialysisPeriodResponseBuilder)?
              updates]) =>
      (new AutomaticPeritonealDialysisPeriodResponseBuilder()..update(updates))
          ._build();

  _$AutomaticPeritonealDialysisPeriodResponse._(
      {required this.peritonealDialysis})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(peritonealDialysis,
        r'AutomaticPeritonealDialysisPeriodResponse', 'peritonealDialysis');
  }

  @override
  AutomaticPeritonealDialysisPeriodResponse rebuild(
          void Function(AutomaticPeritonealDialysisPeriodResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AutomaticPeritonealDialysisPeriodResponseBuilder toBuilder() =>
      new AutomaticPeritonealDialysisPeriodResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AutomaticPeritonealDialysisPeriodResponse &&
        peritonealDialysis == other.peritonealDialysis;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, peritonealDialysis.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AutomaticPeritonealDialysisPeriodResponse')
          ..add('peritonealDialysis', peritonealDialysis))
        .toString();
  }
}

class AutomaticPeritonealDialysisPeriodResponseBuilder
    implements
        Builder<AutomaticPeritonealDialysisPeriodResponse,
            AutomaticPeritonealDialysisPeriodResponseBuilder> {
  _$AutomaticPeritonealDialysisPeriodResponse? _$v;

  ListBuilder<AutomaticPeritonealDialysis>? _peritonealDialysis;
  ListBuilder<AutomaticPeritonealDialysis> get peritonealDialysis =>
      _$this._peritonealDialysis ??=
          new ListBuilder<AutomaticPeritonealDialysis>();
  set peritonealDialysis(
          ListBuilder<AutomaticPeritonealDialysis>? peritonealDialysis) =>
      _$this._peritonealDialysis = peritonealDialysis;

  AutomaticPeritonealDialysisPeriodResponseBuilder() {
    AutomaticPeritonealDialysisPeriodResponse._defaults(this);
  }

  AutomaticPeritonealDialysisPeriodResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _peritonealDialysis = $v.peritonealDialysis.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AutomaticPeritonealDialysisPeriodResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AutomaticPeritonealDialysisPeriodResponse;
  }

  @override
  void update(
      void Function(AutomaticPeritonealDialysisPeriodResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  AutomaticPeritonealDialysisPeriodResponse build() => _build();

  _$AutomaticPeritonealDialysisPeriodResponse _build() {
    _$AutomaticPeritonealDialysisPeriodResponse _$result;
    try {
      _$result = _$v ??
          new _$AutomaticPeritonealDialysisPeriodResponse._(
              peritonealDialysis: peritonealDialysis.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'peritonealDialysis';
        peritonealDialysis.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AutomaticPeritonealDialysisPeriodResponse',
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
