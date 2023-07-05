import '../models/data.dart';

abstract class DataSource {
  Future<List<Result>> getData();
}
