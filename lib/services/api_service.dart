import 'package:nephrolog/models/contract.dart';

class ApiService {
  const ApiService();

  Future<DailyIntakesResponse> getUserIntakesResponse(
    DateTime from,
    DateTime to,
  ) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      final response = DailyIntakesResponse.generateDummy(from, to);
      response.dailyIntakes.sort((a, b) => b.date.compareTo(a.date));

      return response;
    });
  }
}
