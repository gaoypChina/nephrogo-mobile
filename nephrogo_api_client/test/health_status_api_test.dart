import 'package:test/test.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';


/// tests for HealthStatusApi
void main() {
  final instance = NephrogoApiClient().getHealthStatusApi();

  group(HealthStatusApi, () {
    //Future<BloodPressure> healthStatusBloodPressureCreate(BloodPressureRequest bloodPressureRequest) async
    test('test healthStatusBloodPressureCreate', () async {
      // TODO
    });

    //Future healthStatusBloodPressureDestroy(int id) async
    test('test healthStatusBloodPressureDestroy', () async {
      // TODO
    });

    //Future<BloodPressure> healthStatusBloodPressurePartialUpdate(int id, BloodPressureRequest bloodPressureRequest) async
    test('test healthStatusBloodPressurePartialUpdate', () async {
      // TODO
    });

    //Future<BloodPressure> healthStatusBloodPressureUpdate(int id, BloodPressureRequest bloodPressureRequest) async
    test('test healthStatusBloodPressureUpdate', () async {
      // TODO
    });

    //Future<DailyHealthStatus> healthStatusCreate(DailyHealthStatusRequest dailyHealthStatusRequest) async
    test('test healthStatusCreate', () async {
      // TODO
    });

    //Future<DailyHealthStatus> healthStatusPartialUpdate(DailyHealthStatusRequest dailyHealthStatusRequest) async
    test('test healthStatusPartialUpdate', () async {
      // TODO
    });

    //Future<Pulse> healthStatusPulseCreate(PulseRequest pulseRequest) async
    test('test healthStatusPulseCreate', () async {
      // TODO
    });

    //Future healthStatusPulseDestroy(int id) async
    test('test healthStatusPulseDestroy', () async {
      // TODO
    });

    //Future<Pulse> healthStatusPulsePartialUpdate(int id, PulseRequest pulseRequest) async
    test('test healthStatusPulsePartialUpdate', () async {
      // TODO
    });

    //Future<Pulse> healthStatusPulseUpdate(int id, PulseRequest pulseRequest) async
    test('test healthStatusPulseUpdate', () async {
      // TODO
    });

    //Future<DailyHealthStatus> healthStatusRetrieve(Date date) async
    test('test healthStatusRetrieve', () async {
      // TODO
    });

    //Future<HealthStatusScreenResponse> healthStatusScreenRetrieve() async
    test('test healthStatusScreenRetrieve', () async {
      // TODO
    });

    //Future<DailyHealthStatus> healthStatusUpdate(DailyHealthStatusRequest dailyHealthStatusRequest) async
    test('test healthStatusUpdate', () async {
      // TODO
    });

    //Future<HealthStatusWeeklyScreenResponse> healthStatusWeeklyRetrieve(Date from, Date to) async
    test('test healthStatusWeeklyRetrieve', () async {
      // TODO
    });

  });
}
