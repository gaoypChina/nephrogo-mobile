// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_health_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyHealthStatus extends DailyHealthStatus {
  @override
  final Date date;
  @override
  final BuiltList<Swelling> swellings;
  @override
  final BuiltList<BloodPressure> bloodPressures;
  @override
  final BuiltList<Pulse> pulses;
  @override
  final BuiltList<ManualPeritonealDialysis> manualPeritonealDialysis;
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

  factory _$DailyHealthStatus(
          [void Function(DailyHealthStatusBuilder)? updates]) =>
      (new DailyHealthStatusBuilder()..update(updates))._build();

  _$DailyHealthStatus._(
      {required this.date,
      required this.swellings,
      required this.bloodPressures,
      required this.pulses,
      required this.manualPeritonealDialysis,
      this.weightKg,
      this.glucose,
      this.urineMl,
      this.swellingDifficulty,
      this.wellFeeling,
      this.appetite,
      this.shortnessOfBreath})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(date, r'DailyHealthStatus', 'date');
    BuiltValueNullFieldError.checkNotNull(
        swellings, r'DailyHealthStatus', 'swellings');
    BuiltValueNullFieldError.checkNotNull(
        bloodPressures, r'DailyHealthStatus', 'bloodPressures');
    BuiltValueNullFieldError.checkNotNull(
        pulses, r'DailyHealthStatus', 'pulses');
    BuiltValueNullFieldError.checkNotNull(manualPeritonealDialysis,
        r'DailyHealthStatus', 'manualPeritonealDialysis');
  }

  @override
  DailyHealthStatus rebuild(void Function(DailyHealthStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyHealthStatusBuilder toBuilder() =>
      new DailyHealthStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyHealthStatus &&
        date == other.date &&
        swellings == other.swellings &&
        bloodPressures == other.bloodPressures &&
        pulses == other.pulses &&
        manualPeritonealDialysis == other.manualPeritonealDialysis &&
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
    _$hash = $jc(_$hash, bloodPressures.hashCode);
    _$hash = $jc(_$hash, pulses.hashCode);
    _$hash = $jc(_$hash, manualPeritonealDialysis.hashCode);
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
    return (newBuiltValueToStringHelper(r'DailyHealthStatus')
          ..add('date', date)
          ..add('swellings', swellings)
          ..add('bloodPressures', bloodPressures)
          ..add('pulses', pulses)
          ..add('manualPeritonealDialysis', manualPeritonealDialysis)
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

class DailyHealthStatusBuilder
    implements Builder<DailyHealthStatus, DailyHealthStatusBuilder> {
  _$DailyHealthStatus? _$v;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  ListBuilder<Swelling>? _swellings;
  ListBuilder<Swelling> get swellings =>
      _$this._swellings ??= new ListBuilder<Swelling>();
  set swellings(ListBuilder<Swelling>? swellings) =>
      _$this._swellings = swellings;

  ListBuilder<BloodPressure>? _bloodPressures;
  ListBuilder<BloodPressure> get bloodPressures =>
      _$this._bloodPressures ??= new ListBuilder<BloodPressure>();
  set bloodPressures(ListBuilder<BloodPressure>? bloodPressures) =>
      _$this._bloodPressures = bloodPressures;

  ListBuilder<Pulse>? _pulses;
  ListBuilder<Pulse> get pulses => _$this._pulses ??= new ListBuilder<Pulse>();
  set pulses(ListBuilder<Pulse>? pulses) => _$this._pulses = pulses;

  ListBuilder<ManualPeritonealDialysis>? _manualPeritonealDialysis;
  ListBuilder<ManualPeritonealDialysis> get manualPeritonealDialysis =>
      _$this._manualPeritonealDialysis ??=
          new ListBuilder<ManualPeritonealDialysis>();
  set manualPeritonealDialysis(
          ListBuilder<ManualPeritonealDialysis>? manualPeritonealDialysis) =>
      _$this._manualPeritonealDialysis = manualPeritonealDialysis;

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

  DailyHealthStatusBuilder() {
    DailyHealthStatus._defaults(this);
  }

  DailyHealthStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _swellings = $v.swellings.toBuilder();
      _bloodPressures = $v.bloodPressures.toBuilder();
      _pulses = $v.pulses.toBuilder();
      _manualPeritonealDialysis = $v.manualPeritonealDialysis.toBuilder();
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
  void replace(DailyHealthStatus other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DailyHealthStatus;
  }

  @override
  void update(void Function(DailyHealthStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyHealthStatus build() => _build();

  _$DailyHealthStatus _build() {
    _$DailyHealthStatus _$result;
    try {
      _$result = _$v ??
          new _$DailyHealthStatus._(
              date: BuiltValueNullFieldError.checkNotNull(
                  date, r'DailyHealthStatus', 'date'),
              swellings: swellings.build(),
              bloodPressures: bloodPressures.build(),
              pulses: pulses.build(),
              manualPeritonealDialysis: manualPeritonealDialysis.build(),
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
        _$failedField = 'bloodPressures';
        bloodPressures.build();
        _$failedField = 'pulses';
        pulses.build();
        _$failedField = 'manualPeritonealDialysis';
        manualPeritonealDialysis.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DailyHealthStatus', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
