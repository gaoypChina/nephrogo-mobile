import 'package:in_app_review/in_app_review.dart';
import 'package:nephrogo/constants.dart';

class AppReview {
  final InAppReview inAppReview = InAppReview.instance;

  Future<void> openStoreListing() {
    return inAppReview.openStoreListing(appStoreId: Constants.appStoreId);
  }

  Future<void> requestReview() => inAppReview.requestReview();

  Future<bool> isAvailable() => inAppReview.isAvailable();

  Future<bool> shouldShow() async {
    if (!await isAvailable()) {
      return false;
    }

    return true;
  }
}
