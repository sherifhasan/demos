import '../../infrastructure/map/models/data.dart';

abstract class MapboxRepository {
  Future<List<Result>> getData();
}
