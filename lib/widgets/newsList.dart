import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';
import 'package:deinort_app/models/client.dart';
import 'package:deinort_app/redux/state.dart';
import 'package:deinort_app/utils/times.dart';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redux/redux.dart';
import 'package:deinort_app/redux/actions.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:deinort_app/utils/database.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:deinort_app/utils/modals.dart';

class NewsListState extends State<NewsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    super.dispose();
  }

  Null Function(Store<AppState> store, String pid, String cityName) searchNewsByCity = (Store<AppState> store, String pid, String cityName) {
    String geocodeUrl, newsUrl;
    newsUrl = Constants.HEADLINE_NEWS_URL + '/office/' + pid + Constants.NEWS_PARAMS;
    geocodeUrl = Constants.GEOCODE_URL + cityName + Constants.GEOCODE_KEY;

    store.dispatch(ShowLoadingAction());

    try {
      // UserLocation location = new UserLocation(city: cityName);
      Webservice().loadByParams(geocodeUrl, UserLocation.searchByCity).then((location) {
        print(location.city);
        store.dispatch(new FetchLocationAction(location));

        Webservice().loadByParams(newsUrl, NewsArticle.all).then((newsArticles) {
          if (newsArticles != null) {
            store.dispatch(new AddArticlesAction(newsArticles));
          }
        });
      });
    } catch (e) {
      print("error catch!!!!!!!!!!!!!");
      print(e.toString());
      store.dispatch(new ErrorHanlderAction(e.toString()));
    }
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            StoreConnector<AppState, UserLocation>(
              converter: (store) {
                return store.state.location;
              },
              builder: (_, _location) {
                if (_location != null) {
                  return Image.network(
                    'https://maps.googleapis.com/maps/api/staticmap?center=-' + _location.latitude +
                    ','+ _location.longitude + '&size=' + size.width.toInt().toString() + 'x'
                    + size.height.toInt().toString() + '&zoom=16&key=' + Constants.GOOGLE_MAP_KEY,
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.fill,
                  );
                } else {
                  return Image.asset(
                    'google.com',
                    width: size.width,
                    height: size.height
                  );
                }
              }
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.only(top: 0.0),
              padding: const EdgeInsets.only(top: 30, right: 10, bottom: 10, left: 0),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: Image.asset(
                    'assets/logo.jpg',
                    width: 50,
                    height: 30,
                  )),
                  StoreConnector<AppState, AppState>(
                    converter: (store) {
                      return store.state;
                    },
                    builder: (_, _state) {
                      if (_state.isLoading == false) {
                        
                        return Expanded(
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(blurRadius: 5),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                            ),
                            child: TextField(
                              onSubmitted: (text) async {
                                final store = StoreProvider.of<AppState>(context);
                                List<Client> polices = await DBProvider.db.getClientsByCity(text);

                                if (polices != null) {
                                  store.dispatch(EmptyArticlesAction());

                                  for (var i =0; i < polices.length; i ++) {
                                    store.dispatch(searchNewsByCity(store, polices[i].pid, text));
                                    sleep();
                                  }
                                } else {
                                  store.dispatch(new ErrorHanlderAction('City name is invalide'));
                                }
                              },
                              style: new TextStyle(
                                height: 1.5,
                                color: Colors.grey                  
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter a search key',
                              )
                            )
                          )
                        );
                      } else {
                        return SpinKitRotatingCircle(color: Colors.white);
                      }
                    }
                  ),
                ]
              )
            ),
            StoreConnector<AppState, AppState>(
              converter: (store) {
                return store.state;
              },
              builder: (_, _state) {
                var _location = _state.location;
                var _articles = _state.articles;
                String _address = _location !=null && _location.address != null ? _location.address + ', ' : '';
                String _city = _location !=null && _location.city != null ? _location.city : '';

                if (_state.error != null && _state.error != "") {
                  print(_state.error);
                  return AlertDialog(
                    content: new Text(_state.error),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          // Navigator.of(context, rootNavigator: true).pop('dialog');
                        },
                      ),
                    ],
                  );
                }

                if (_articles == null) {
                  return Container(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      child: Center(
                        child: SpinKitFadingCircle(color: Colors.green),
                      ),
                    );
                } else {
                  return Container(
                    width: size.width,
                    height: 340,
                    margin: const EdgeInsets.only(top: 220.0),
                    padding: const EdgeInsets.only(top: 10.0),
                    color: Colors.blue,
                    child: Stack(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 20),
                        child: Text(
                          _address + _city,
                          style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 0,
                        bottom: 0,
                        left: 0,

                        child: ListView.builder(
                          itemCount: _articles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        // align the text to the left instead of centered
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            readTimestamp(_articles[index].published),
                                            style: TextStyle(fontSize: 15)
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              _articles[index].officeName,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.greenAccent
                                                )
                                            )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              _articles[index].title,
                                              style: TextStyle(fontSize: 18)
                                            )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              _articles[index].body.substring(0, 200) + ' ...',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontStyle: FontStyle.italic,
                                                fontFamily: "Open Sans",
                                              )
                                            )
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      )
                    ],),
                  );
                }
              }
            ),
            StoreConnector<AppState, bool>(
              converter: (store) {
                return store.state.isLoading;
              },
              builder: (_, _isLoading) {
                if (_isLoading) {
                  return Container(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    child: Center(
                      child: SpinKitFadingCircle(color: Colors.green),
                    ),
                  );
                } else {
                  return Container();
                }
              }
            ),
          ],
        )
      );
  }
}

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState();
}