import 'package:redux/redux.dart';
import 'package:redux_example/domain/domain.dart';

homeMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is GetRandomDogPhotoAction) {
    getRandomDogPhoto().then((imagePath) {
      if (imagePath != null) {
        store.dispatch(LoadRandomDogPhotoAction(imagePath));
      }
    });
  }
  next(action);
}
