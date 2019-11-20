import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deinort_app/widgets/newsList.dart';
import 'package:deinort_app/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:location/location.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:deinort_app/redux/reducer.dart';
import 'package:deinort_app/models/location.dart';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';
import 'package:deinort_app/redux/actions.dart';
import 'package:deinort_app/models/newsArticle.dart';

final myLocation = new Location();
var currentLocation;

Future<void> getCurrentLocation() async {
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    currentLocation = await myLocation.getLocation();
  } catch (e) {
    currentLocation = null;
    print(e.toString());
  }
}

void main() async {
  print("main");
  await getCurrentLocation();

  return runApp(App());
}

final store = new Store<AppState>(appStateReducers,
    initialState: new AppState([]), middleware: [thunkMiddleware]);

ThunkAction<AppState> populateNewsArticles = (Store<AppState> store) {
  String newsUrl, geocodeUrl;
  geocodeUrl = Constants.GEOCODE_URL + currentLocation['latitude'].toString() + ','
  + currentLocation['longitude'].toString() + Constants.GEOCODE_KEY;

  Webservice().loadByParams(geocodeUrl, UserLocation.info).then((location) {
    newsUrl = Constants.HEADLINE_NEWS_URL + '/region/' + location.state + Constants.NEWS_PARAMS;

    Webservice().loadByParams(newsUrl, NewsArticle.all).then((newsArticles) {
      store.dispatch(new FetchArticlesAction(newsArticles));
    });
  });
};

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    store.dispatch(populateNewsArticles);
    return StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'Deinort',
        home: NewsList(),
      ),
    );
  }

}
