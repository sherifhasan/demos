import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverbloc/riverbloc.dart';

import '../../../domain/map/mapbox_repository.dart';
import '../../../infrastructure/map/mapbox_repository_imp.dart';
import '../../../infrastructure/map/models/data.dart';

part 'map_cubit.freezed.dart';

part 'map_data_state.dart';

final mapDataCubitProvider =
    BlocProvider.autoDispose<MapDataCubit, MapDataState>(
        (ref) => MapDataCubit(ref.watch(mapboxRepositoryProvider)));

class MapDataCubit extends Cubit<MapDataState> {
  final MapboxRepository _repository;

  MapDataCubit(this._repository) : super(const MapDataState.initial());

  Future<void> init() async {
    final res = await _repository.getData();
    if (res.isNotEmpty) {
      emit(MapDataState.data(res));
    }
  }
}
