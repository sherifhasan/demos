import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_example/domain/domain.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redux demo'),
      ),
      body: StoreBuilder<AppState>(
        onInit: (Store<AppState> store) {
          store.dispatch(GetRandomDogPhotoAction());
        },
        builder: (BuildContext ctx, Store<AppState> store) {
          return SafeArea(
            bottom: true,
            child: Center(
              child: store.state.homeState.imagePath.isEmpty
                  ? const CircularProgressIndicator()
                  : Stack(
                      children: [
                        Image.network(
                          store.state.homeState.imagePath,
                          fit: BoxFit.cover,
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () =>
                                store.dispatch(GetRandomDogPhotoAction()),
                            child: const Text('Zufälliges Foto'),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
