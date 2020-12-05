import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';

class ApiService {
  const ApiService();

  Future<DailyIntakesResponse> getUserIntakesResponse(
    DateTime from,
    DateTime to,
  ) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      final response = DailyIntakesResponse.generateDummy(from, to);
      response.dailyIntakes.sortedBy((e) => e.date, true);

      return response;
    });
  }
}
