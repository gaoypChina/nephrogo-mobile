// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_app_review.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserAppReview extends UserAppReview {
  @override
  final bool showAppReviewDialog;

  factory _$UserAppReview([void Function(UserAppReviewBuilder)? updates]) =>
      (new UserAppReviewBuilder()..update(updates))._build();

  _$UserAppReview._({required this.showAppReviewDialog}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        showAppReviewDialog, r'UserAppReview', 'showAppReviewDialog');
  }

  @override
  UserAppReview rebuild(void Function(UserAppReviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserAppReviewBuilder toBuilder() => new UserAppReviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserAppReview &&
        showAppReviewDialog == other.showAppReviewDialog;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, showAppReviewDialog.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserAppReview')
          ..add('showAppReviewDialog', showAppReviewDialog))
        .toString();
  }
}

class UserAppReviewBuilder
    implements Builder<UserAppReview, UserAppReviewBuilder> {
  _$UserAppReview? _$v;

  bool? _showAppReviewDialog;
  bool? get showAppReviewDialog => _$this._showAppReviewDialog;
  set showAppReviewDialog(bool? showAppReviewDialog) =>
      _$this._showAppReviewDialog = showAppReviewDialog;

  UserAppReviewBuilder() {
    UserAppReview._defaults(this);
  }

  UserAppReviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _showAppReviewDialog = $v.showAppReviewDialog;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserAppReview other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserAppReview;
  }

  @override
  void update(void Function(UserAppReviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserAppReview build() => _build();

  _$UserAppReview _build() {
    final _$result = _$v ??
        new _$UserAppReview._(
            showAppReviewDialog: BuiltValueNullFieldError.checkNotNull(
                showAppReviewDialog, r'UserAppReview', 'showAppReviewDialog'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
