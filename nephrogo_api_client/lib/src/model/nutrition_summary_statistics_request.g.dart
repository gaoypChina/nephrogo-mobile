// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_summary_statistics_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NutritionSummaryStatisticsRequest
    extends NutritionSummaryStatisticsRequest {
  @override
  final Date? minReportDate;
  @override
  final Date? maxReportDate;

  factory _$NutritionSummaryStatisticsRequest(
          [void Function(NutritionSummaryStatisticsRequestBuilder)? updates]) =>
      (new NutritionSummaryStatisticsRequestBuilder()..update(updates))
          ._build();

  _$NutritionSummaryStatisticsRequest._(
      {this.minReportDate, this.maxReportDate})
      : super._();

  @override
  NutritionSummaryStatisticsRequest rebuild(
          void Function(NutritionSummaryStatisticsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NutritionSummaryStatisticsRequestBuilder toBuilder() =>
      new NutritionSummaryStatisticsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NutritionSummaryStatisticsRequest &&
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
    return (newBuiltValueToStringHelper(r'NutritionSummaryStatisticsRequest')
          ..add('minReportDate', minReportDate)
          ..add('maxReportDate', maxReportDate))
        .toString();
  }
}

class NutritionSummaryStatisticsRequestBuilder
    implements
        Builder<NutritionSummaryStatisticsRequest,
            NutritionSummaryStatisticsRequestBuilder> {
  _$NutritionSummaryStatisticsRequest? _$v;

  Date? _minReportDate;
  Date? get minReportDate => _$this._minReportDate;
  set minReportDate(Date? minReportDate) =>
      _$this._minReportDate = minReportDate;

  Date? _maxReportDate;
  Date? get maxReportDate => _$this._maxReportDate;
  set maxReportDate(Date? maxReportDate) =>
      _$this._maxReportDate = maxReportDate;

  NutritionSummaryStatisticsRequestBuilder() {
    NutritionSummaryStatisticsRequest._defaults(this);
  }

  NutritionSummaryStatisticsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _minReportDate = $v.minReportDate;
      _maxReportDate = $v.maxReportDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NutritionSummaryStatisticsRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NutritionSummaryStatisticsRequest;
  }

  @override
  void update(
      void Function(NutritionSummaryStatisticsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NutritionSummaryStatisticsRequest build() => _build();

  _$NutritionSummaryStatisticsRequest _build() {
    final _$result = _$v ??
        new _$NutritionSummaryStatisticsRequest._(
            minReportDate: minReportDate, maxReportDate: maxReportDate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
