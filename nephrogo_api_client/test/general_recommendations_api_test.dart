import 'package:test/test.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';


/// tests for GeneralRecommendationsApi
void main() {
  final instance = NephrogoApiClient().getGeneralRecommendationsApi();

  group(GeneralRecommendationsApi, () {
    //Future<CreateGeneralRecommendationRead> generalRecommendationsReadCreate(CreateGeneralRecommendationReadRequest createGeneralRecommendationReadRequest) async
    test('test generalRecommendationsReadCreate', () async {
      // TODO
    });

    //Future<GeneralRecommendationsResponse> generalRecommendationsV2Retrieve() async
    test('test generalRecommendationsV2Retrieve', () async {
      // TODO
    });

  });
}
