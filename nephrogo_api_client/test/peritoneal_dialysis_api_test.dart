import 'package:test/test.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';


/// tests for PeritonealDialysisApi
void main() {
  final instance = NephrogoApiClient().getPeritonealDialysisApi();

  group(PeritonealDialysisApi, () {
    //Future<AutomaticPeritonealDialysis> peritonealDialysisAutomaticDialysisCreateCreate(AutomaticPeritonealDialysisRequest automaticPeritonealDialysisRequest) async
    test('test peritonealDialysisAutomaticDialysisCreateCreate', () async {
      // TODO
    });

    //Future peritonealDialysisAutomaticDialysisDestroy(Date date) async
    test('test peritonealDialysisAutomaticDialysisDestroy', () async {
      // TODO
    });

    //Future<AutomaticPeritonealDialysis> peritonealDialysisAutomaticDialysisPartialUpdate(Date date, AutomaticPeritonealDialysisRequest automaticPeritonealDialysisRequest) async
    test('test peritonealDialysisAutomaticDialysisPartialUpdate', () async {
      // TODO
    });

    //Future<AutomaticPeritonealDialysis> peritonealDialysisAutomaticDialysisUpdate(Date date, AutomaticPeritonealDialysisRequest automaticPeritonealDialysisRequest) async
    test('test peritonealDialysisAutomaticDialysisUpdate', () async {
      // TODO
    });

    //Future<AutomaticPeritonealDialysisPeriodResponse> peritonealDialysisAutomaticPeriodRetrieve(Date from, Date to) async
    test('test peritonealDialysisAutomaticPeriodRetrieve', () async {
      // TODO
    });

    //Future<AutomaticPeritonealDialysisScreenResponse> peritonealDialysisAutomaticScreenRetrieve() async
    test('test peritonealDialysisAutomaticScreenRetrieve', () async {
      // TODO
    });

    //Future<ManualPeritonealDialysis> peritonealDialysisManualDialysisCreateCreate(ManualPeritonealDialysisRequest manualPeritonealDialysisRequest) async
    test('test peritonealDialysisManualDialysisCreateCreate', () async {
      // TODO
    });

    //Future peritonealDialysisManualDialysisDestroy(int id) async
    test('test peritonealDialysisManualDialysisDestroy', () async {
      // TODO
    });

    //Future<ManualPeritonealDialysis> peritonealDialysisManualDialysisPartialUpdate(int id, ManualPeritonealDialysisRequest manualPeritonealDialysisRequest) async
    test('test peritonealDialysisManualDialysisPartialUpdate', () async {
      // TODO
    });

    //Future<ManualPeritonealDialysis> peritonealDialysisManualDialysisUpdate(int id, ManualPeritonealDialysisRequest manualPeritonealDialysisRequest) async
    test('test peritonealDialysisManualDialysisUpdate', () async {
      // TODO
    });

    //Future<ManualPeritonealDialysisScreenResponse> peritonealDialysisManualScreenV2Retrieve() async
    test('test peritonealDialysisManualScreenV2Retrieve', () async {
      // TODO
    });

  });
}
