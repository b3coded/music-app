import 'package:flutter/material.dart';
import 'package:music_app/my_app.dart';
import 'package:music_app/utils/themes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Increment }

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }

  return state;
}

void main() {
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final store = new Store<int>(counterReducer, initialState: 0);
  runApp(new MyMaterialApp(store: store));
}

class MyMaterialApp extends StatelessWidget {
  final Store<int> store;

  MyMaterialApp({Key key, this.store }): super(key: key);

  @override
  Widget build(BuildContext context) {

    return new StoreProvider<int>(
        // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
        // Widgets will find and use this value as the `Store`.
        store: store,
        child: new MaterialApp(
          title:  new StoreConnector<int, String>(
            converter: (store) => store.state.toString(),
            builder: (context, count) {
              return new Text(
                count,
                style: Theme.of(context).textTheme.display1,
              );
            },
          ).toString(),
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: new MyApp())
    );
  }
}

