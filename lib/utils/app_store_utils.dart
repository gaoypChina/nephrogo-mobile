import 'dart:io' show Platform;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/preferences/app_preferences.dart';

class AppReview {
  final InAppReview _inAppReview = InAppReview.instance;

  final _apiService = ApiService();

  Future<void> openStoreListing() {
    return _inAppReview.openStoreListing(appStoreId: Constants.appStoreId);
  }

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<bool> _isAvailable() => _inAppReview.isAvailable();

  Future<bool> requestReviewConditionally() async {
    if (!await _isAvailable()) {
      return false;
    }

    final appReview = await _apiService.getUserAppReview();
    if (!appReview.showAppReviewDialog) {
      return false;
    }

    await _requestReview();
    return true;
  }
}

enum AppUpdateState {
  no,
  error,
  flexible,
  immediate,
}

class AppUpdate {
  final _appPreferences = AppPreferences();

  Future<bool> _isUpdateAllowedForUser() async {
    if (!Platform.isAndroid) {
      return false;
    }

    final now = DateTime.now();
    final lastAskedDate =
        await _appPreferences.getInAppUpdateLastPromptedDate();

    if (lastAskedDate != null &&
        now.difference(lastAskedDate.toLocal()) < const Duration(hours: 24)) {
      return false;
    }

    return true;
  }

  Future<AppUpdateState> performInAppUpdateIfNeeded() async {
    if (!await _isUpdateAllowedForUser()) {
      return AppUpdateState.no;
    }

    final appUpdateInfo = await InAppUpdate.checkForUpdate();

    if (!appUpdateInfo.updateAvailable) {
      return AppUpdateState.no;
    }

    await _appPreferences.setInAppUpdateLastPromptedDate(DateTime.now());

    if (appUpdateInfo.flexibleUpdateAllowed) {
      try {
        await InAppUpdate.startFlexibleUpdate();
      } catch (exception, stack) {
        FirebaseCrashlytics.instance.recordError(exception, stack);

        return AppUpdateState.error;
      }

      return AppUpdateState.flexible;
    }

    if (appUpdateInfo.immediateUpdateAllowed) {
      try {
        await InAppUpdate.performImmediateUpdate();
      } catch (exception, stack) {
        FirebaseCrashlytics.instance.recordError(exception, stack);

        return AppUpdateState.error;
      }

      return AppUpdateState.immediate;
    }

    return AppUpdateState.no;
  }

  Future<void> completeFlexibleUpdate() {
    return InAppUpdate.completeFlexibleUpdate();
  }
}
