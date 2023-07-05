import 'package:redux_example/domain/domain.dart';

HomeState homeReducer(HomeState state, action) {
  if (action is LoadRandomDogPhotoAction) {
    return state.copyWith(imagePath: action.dogImageUrl);
  }
  return state;
}
