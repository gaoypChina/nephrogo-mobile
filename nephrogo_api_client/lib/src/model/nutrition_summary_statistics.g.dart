// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_summary_statistics.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NutritionSummaryStatistics extends NutritionSummaryStatistics {
  @override
  final Date? minReportDate;
  @override
  final Date? maxReportDate;

  factory _$NutritionSummaryStatistics(
          [void Function(NutritionSummaryStatisticsBuilder)? updates]) =>
      (new NutritionSummaryStatisticsBuilder()..update(updates))._build();

  _$NutritionSummaryStatistics._({this.minReportDate, this.maxReportDate})
      : super._();

  @override
  NutritionSummaryStatistics rebuild(
          void Function(NutritionSummaryStatisticsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NutritionSummaryStatisticsBuilder toBuilder() =>
      new NutritionSummaryStatisticsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NutritionSummaryStatistics &&
        minReportDate == other.minReportDate &&
        maxReportDate == other.maxReportDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, minReportDate.hashCode);
    _$hash = $jc(_$hash, maxReportDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NutritionSummaryStatistics')
          ..add('minReportDate', minReportDate)
          ..add('maxReportDate', maxReportDate))
        .toString();
  }
}

class NutritionSummaryStatisticsBuilder
    implements
        Builder<NutritionSummaryStatistics, NutritionSummaryStatisticsBuilder> {
  _$NutritionSummaryStatistics? _$v;

  Date? _minReportDate;
  Date? get minReportDate => _$this._minReportDate;
  set minReportDate(Date? minReportDate) =>
      _$this._minReportDate = minReportDate;

  Date? _maxReportDate;
  Date? get maxReportDate => _$this._maxReportDate;
  set maxReportDate(Date? maxReportDate) =>
      _$this._maxReportDate = maxReportDate;

  NutritionSummaryStatisticsBuilder() {
    NutritionSummaryStatistics._defaults(this);
  }

  NutritionSummaryStatisticsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _minReportDate = $v.minReportDate;
      _maxReportDate = $v.maxReportDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NutritionSummaryStatistics other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NutritionSummaryStatistics;
  }

  @override
  void update(void Function(NutritionSummaryStatisticsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NutritionSummaryStatistics build() => _build();

  _$NutritionSummaryStatistics _build() {
    final _$result = _$v ??
        new _$NutritionSummaryStatistics._(
            minReportDate: minReportDate, maxReportDate: maxReportDate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
