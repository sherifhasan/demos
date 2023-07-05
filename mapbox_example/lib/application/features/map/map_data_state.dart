part of 'map_cubit.dart';

@freezed
class MapDataState with _$MapDataState {
  const factory MapDataState.initial() = _Initial;
  const factory MapDataState.loading() = _Loading;

  const factory MapDataState.data(List<Result> results) = _Data;
}
