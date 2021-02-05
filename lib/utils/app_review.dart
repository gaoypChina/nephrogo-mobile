import 'package:in_app_review/in_app_review.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';

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
