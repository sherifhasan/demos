import 'package:redux_example/domain/domain.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    homeState: homeReducer(state.homeState, action),
  );
}
