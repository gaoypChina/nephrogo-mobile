// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_health_status_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyHealthStatusRequest extends DailyHealthStatusRequest {
  @override
  final Date date;
  @override
  final BuiltList<SwellingRequest> swellings;
  @override
  final double? weightKg;
  @override
  final double? glucose;
  @override
  final int? urineMl;
  @override
  final SwellingDifficultyEnum? swellingDifficulty;
  @override
  final WellFeelingEnum? wellFeeling;
  @override
  final AppetiteEnum? appetite;
  @override
  final ShortnessOfBreathEnum? shortnessOfBreath;

  factory _$DailyHealthStatusRequest(
          [void Function(DailyHealthStatusRequestBuilder)? updates]) =>
      (new DailyHealthStatusRequestBuilder()..update(updates))._build();

  _$DailyHealthStatusRequest._(
      {required this.date,
      required this.swellings,
      this.weightKg,
      this.glucose,
      this.urineMl,
      this.swellingDifficulty,
      this.wellFeeling,
      this.appetite,
      this.shortnessOfBreath})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        date, r'DailyHealthStatusRequest', 'date');
    BuiltValueNullFieldError.checkNotNull(
        swellings, r'DailyHealthStatusRequest', 'swellings');
  }

  @override
  DailyHealthStatusRequest rebuild(
          void Function(DailyHealthStatusRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyHealthStatusRequestBuilder toBuilder() =>
      new DailyHealthStatusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyHealthStatusRequest &&
        date == other.date &&
        swellings == other.swellings &&
        weightKg == other.weightKg &&
        glucose == other.glucose &&
        urineMl == other.urineMl &&
        swellingDifficulty == other.swellingDifficulty &&
        wellFeeling == other.wellFeeling &&
        appetite == other.appetite &&
        shortnessOfBreath == other.shortnessOfBreath;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, swellings.hashCode);
    _$hash = $jc(_$hash, weightKg.hashCode);
    _$hash = $jc(_$hash, glucose.hashCode);
    _$hash = $jc(_$hash, urineMl.hashCode);
    _$hash = $jc(_$hash, swellingDifficulty.hashCode);
    _$hash = $jc(_$hash, wellFeeling.hashCode);
    _$hash = $jc(_$hash, appetite.hashCode);
    _$hash = $jc(_$hash, shortnessOfBreath.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyHealthStatusRequest')
          ..add('date', date)
          ..add('swellings', swellings)
          ..add('weightKg', weightKg)
          ..add('glucose', glucose)
          ..add('urineMl', urineMl)
          ..add('swellingDifficulty', swellingDifficulty)
          ..add('wellFeeling', wellFeeling)
          ..add('appetite', appetite)
          ..add('shortnessOfBreath', shortnessOfBreath))
        .toString();
  }
}

class DailyHealthStatusRequestBuilder
    implements
        Builder<DailyHealthStatusRequest, DailyHealthStatusRequestBuilder> {
  _$DailyHealthStatusRequest? _$v;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  ListBuilder<SwellingRequest>? _swellings;
  ListBuilder<SwellingRequest> get swellings =>
      _$this._swellings ??= new ListBuilder<SwellingRequest>();
  set swellings(ListBuilder<SwellingRequest>? swellings) =>
      _$this._swellings = swellings;

  double? _weightKg;
  double? get weightKg => _$this._weightKg;
  set weightKg(double? weightKg) => _$this._weightKg = weightKg;

  double? _glucose;
  double? get glucose => _$this._glucose;
  set glucose(double? glucose) => _$this._glucose = glucose;

  int? _urineMl;
  int? get urineMl => _$this._urineMl;
  set urineMl(int? urineMl) => _$this._urineMl = urineMl;

  SwellingDifficultyEnum? _swellingDifficulty;
  SwellingDifficultyEnum? get swellingDifficulty => _$this._swellingDifficulty;
  set swellingDifficulty(SwellingDifficultyEnum? swellingDifficulty) =>
      _$this._swellingDifficulty = swellingDifficulty;

  WellFeelingEnum? _wellFeeling;
  WellFeelingEnum? get wellFeeling => _$this._wellFeeling;
  set wellFeeling(WellFeelingEnum? wellFeeling) =>
      _$this._wellFeeling = wellFeeling;

  AppetiteEnum? _appetite;
  AppetiteEnum? get appetite => _$this._appetite;
  set appetite(AppetiteEnum? appetite) => _$this._appetite = appetite;

  ShortnessOfBreathEnum? _shortnessOfBreath;
  ShortnessOfBreathEnum? get shortnessOfBreath => _$this._shortnessOfBreath;
  set shortnessOfBreath(ShortnessOfBreathEnum? shortnessOfBreath) =>
      _$this._shortnessOfBreath = shortnessOfBreath;

  DailyHealthStatusRequestBuilder() {
    DailyHealthStatusRequest._defaults(this);
  }

  DailyHealthStatusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _swellings = $v.swellings.toBuilder();
      _weightKg = $v.weightKg;
      _glucose = $v.glucose;
      _urineMl = $v.urineMl;
      _swellingDifficulty = $v.swellingDifficulty;
      _wellFeeling = $v.wellFeeling;
      _appetite = $v.appetite;
      _shortnessOfBreath = $v.shortnessOfBreath;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyHealthStatusRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DailyHealthStatusRequest;
  }

  @override
  void update(void Function(DailyHealthStatusRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyHealthStatusRequest build() => _build();

  _$DailyHealthStatusRequest _build() {
    _$DailyHealthStatusRequest _$result;
    try {
      _$result = _$v ??
          new _$DailyHealthStatusRequest._(
              date: BuiltValueNullFieldError.checkNotNull(
                  date, r'DailyHealthStatusRequest', 'date'),
              swellings: swellings.build(),
              weightKg: weightKg,
              glucose: glucose,
              urineMl: urineMl,
              swellingDifficulty: swellingDifficulty,
              wellFeeling: wellFeeling,
              appetite: appetite,
              shortnessOfBreath: shortnessOfBreath);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'swellings';
        swellings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DailyHealthStatusRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
