import 'package:riverbloc/riverbloc.dart';

import '../../domain/map/mapbox_repository.dart';
import 'datasource/data_source.dart';
import 'datasource/data_source_imp.dart';
import 'models/data.dart';

final mapboxRepositoryProvider = Provider<MapboxRepository>((ref) {
  return MapboxRepositoryImp(ref.watch(mapboxDataSourceProvider));
});

class MapboxRepositoryImp extends MapboxRepository {
  final DataSource _dataSource;

  MapboxRepositoryImp(this._dataSource);

  @override
  Future<List<Result>> getData() async {
    return await _dataSource.getData();
  }
}
