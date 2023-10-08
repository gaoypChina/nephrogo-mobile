import 'package:test/test.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';


/// tests for UserApi
void main() {
  final instance = NephrogoApiClient().getUserApi();

  group(UserApi, () {
    //Future<UserAppReview> userAppReviewRetrieve() async
    test('test userAppReviewRetrieve', () async {
      // TODO
    });

    //Future<CountryResponse> userCountriesRetrieve() async
    test('test userCountriesRetrieve', () async {
      // TODO
    });

    //Future userDestroy() async
    test('test userDestroy', () async {
      // TODO
    });

    //Future<User> userPartialUpdate({ UserRequest userRequest }) async
    test('test userPartialUpdate', () async {
      // TODO
    });

    //Future<UserProfileV2> userProfileV2Create(UserProfileV2Request userProfileV2Request) async
    test('test userProfileV2Create', () async {
      // TODO
    });

    //Future<UserProfileV2> userProfileV2PartialUpdate(UserProfileV2Request userProfileV2Request) async
    test('test userProfileV2PartialUpdate', () async {
      // TODO
    });

    //Future<UserProfileV2> userProfileV2Retrieve() async
    test('test userProfileV2Retrieve', () async {
      // TODO
    });

    //Future<UserProfileV2> userProfileV2Update(UserProfileV2Request userProfileV2Request) async
    test('test userProfileV2Update', () async {
      // TODO
    });

    //Future<User> userRetrieve() async
    test('test userRetrieve', () async {
      // TODO
    });

    //Future<User> userUpdate({ UserRequest userRequest }) async
    test('test userUpdate', () async {
      // TODO
    });

  });
}
