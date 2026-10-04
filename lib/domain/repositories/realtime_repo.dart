import 'package:edencrew_assignment_starter/domain/entity/realtime_entity.dart';

abstract class RealtimeRepo {
  Future<Map<String, RealtimeEntity>> getRealtimeData(
    List<String> stockCodeList,
  );
}
