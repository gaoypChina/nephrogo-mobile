// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_status_weekly_screen_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealthStatusWeeklyScreenResponse
    extends HealthStatusWeeklyScreenResponse {
  @override
  final Date? earliestHealthStatusDate;
  @override
  final BuiltList<DailyHealthStatus> dailyHealthStatuses;

  factory _$HealthStatusWeeklyScreenResponse(
          [void Function(HealthStatusWeeklyScreenResponseBuilder)? updates]) =>
      (new HealthStatusWeeklyScreenResponseBuilder()..update(updates))._build();

  _$HealthStatusWeeklyScreenResponse._(
      {this.earliestHealthStatusDate, required this.dailyHealthStatuses})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(dailyHealthStatuses,
        r'HealthStatusWeeklyScreenResponse', 'dailyHealthStatuses');
  }

  @override
  HealthStatusWeeklyScreenResponse rebuild(
          void Function(HealthStatusWeeklyScreenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealthStatusWeeklyScreenResponseBuilder toBuilder() =>
      new HealthStatusWeeklyScreenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthStatusWeeklyScreenResponse &&
        earliestHealthStatusDate == other.earliestHealthStatusDate &&
        dailyHealthStatuses == other.dailyHealthStatuses;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, earliestHealthStatusDate.hashCode);
    _$hash = $jc(_$hash, dailyHealthStatuses.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealthStatusWeeklyScreenResponse')
          ..add('earliestHealthStatusDate', earliestHealthStatusDate)
          ..add('dailyHealthStatuses', dailyHealthStatuses))
        .toString();
  }
}

class HealthStatusWeeklyScreenResponseBuilder
    implements
        Builder<HealthStatusWeeklyScreenResponse,
            HealthStatusWeeklyScreenResponseBuilder> {
  _$HealthStatusWeeklyScreenResponse? _$v;

  Date? _earliestHealthStatusDate;
  Date? get earliestHealthStatusDate => _$this._earliestHealthStatusDate;
  set earliestHealthStatusDate(Date? earliestHealthStatusDate) =>
      _$this._earliestHealthStatusDate = earliestHealthStatusDate;

  ListBuilder<DailyHealthStatus>? _dailyHealthStatuses;
  ListBuilder<DailyHealthStatus> get dailyHealthStatuses =>
      _$this._dailyHealthStatuses ??= new ListBuilder<DailyHealthStatus>();
  set dailyHealthStatuses(
          ListBuilder<DailyHealthStatus>? dailyHealthStatuses) =>
      _$this._dailyHealthStatuses = dailyHealthStatuses;

  HealthStatusWeeklyScreenResponseBuilder() {
    HealthStatusWeeklyScreenResponse._defaults(this);
  }

  HealthStatusWeeklyScreenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _earliestHealthStatusDate = $v.earliestHealthStatusDate;
      _dailyHealthStatuses = $v.dailyHealthStatuses.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthStatusWeeklyScreenResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HealthStatusWeeklyScreenResponse;
  }

  @override
  void update(void Function(HealthStatusWeeklyScreenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthStatusWeeklyScreenResponse build() => _build();

  _$HealthStatusWeeklyScreenResponse _build() {
    _$HealthStatusWeeklyScreenResponse _$result;
    try {
      _$result = _$v ??
          new _$HealthStatusWeeklyScreenResponse._(
              earliestHealthStatusDate: earliestHealthStatusDate,
              dailyHealthStatuses: dailyHealthStatuses.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dailyHealthStatuses';
        dailyHealthStatuses.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HealthStatusWeeklyScreenResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
