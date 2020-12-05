import 'package:nephrolog/models/contract.dart';

class ApiService {
  const ApiService();

  Future<UserIntakesResponse> getUserIntakes(
    DateTime from,
    DateTime to,
  ) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      final response = UserIntakesResponse.generateDummy(from, to);

      response.dailyIntakes.sort((a, b) => b.date.compareTo(a.date));

      return response;
    });
  }

  Future<UserHealthStatusResponse> getUserHealthStatus(
    DateTime from,
    DateTime to,
  ) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      final response = UserHealthStatusResponse.generateDummy(from, to);

      response.dailyHealthStatuses.sort((a, b) => b.date.compareTo(a.date));

      return response;
    });
  }
}
