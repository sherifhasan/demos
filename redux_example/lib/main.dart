import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_example/ui/home_screen.dart';

import 'domain/domain.dart';

void main() {
  runApp(App());
}

loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  debugPrint('${DateTime.now()} $action ');
  next(action);
}

AppState init() => AppState(
      homeState: HomeState(imagePath: ''),
    );

class App extends StatelessWidget {
  final store =
      Store<AppState>(appStateReducer, initialState: init(), middleware: [
    loggingMiddleware,
    homeMiddleware,
  ]);

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Redux Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
