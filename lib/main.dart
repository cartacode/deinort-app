import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deinort_app/widgets/newsList.dart';
import 'package:deinort_app/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/redux/actions.dart';
import 'package:deinort_app/redux/reducer.dart';

void main() => runApp(App());

final store = new Store<AppState>(appStateReducers,
    initialState: new AppState([]), middleware: [thunkMiddleware]);

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'Deinort',
        home: NewsList(),
      ),
    );
  }

}
