class HomeState {
  final String imagePath;

  HomeState({required this.imagePath});

  HomeState copyWith({String? imagePath}) {
    return HomeState(
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
