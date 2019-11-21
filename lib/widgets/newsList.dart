
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';
import 'package:deinort_app/redux/state.dart';
import 'package:deinort_app/utils/times.dart';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';
import 'package:redux/redux.dart';
import 'package:deinort_app/redux/actions.dart';
import 'package:redux_thunk/redux_thunk.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/google.jpg',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.only(top: 10.0),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: Image.asset(
                    'assets/logo.jpg',
                    width: 50,
                    height: 30,
                  )),
                  Expanded(child: TextField(
                    onSubmitted: (text) {
                       print("Second text field: ${text}");
                    },
                    style: new TextStyle(
                      height: 2.0,
                      color: Colors.grey                  
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: 'Enter a search key',
                    ),
                  )),
                ]
              )
            ),
            Container(
              height: 340,
              margin: const EdgeInsets.only(top: 220.0),
              padding: const EdgeInsets.only(top: 10.0),
              color: Colors.blue,
              child: Stack(children: <Widget>[
                StoreConnector<AppState, UserLocation>(
                  converter: (store) {
                    return store.state.location;
                  },
                  builder: (_, _location) {
                    String _address = _location !=null && _location.address != null ? _location.address + ', ' : '';
                    String _city = _location !=null && _location.city != null ? _location.city : '';
                    return Text(
                      _address + _city,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                    );
                  }
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 40,
                    right: 10,
                    bottom: 10,
                    left: 10),
                  color: Color(0xFFFFFFFF),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(const Radius.circular(20.0))
                  ),
                  child: StoreConnector<AppState, List<NewsArticle>>(
                    converter: (store) {
                      return store.state.articles;
                    },
                      builder: (_, _articles) {
                        return ListView.builder(
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
                                              _articles[index].body,
                                            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)
                                            )
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                              // return ListTile(
                              //   title: Text(_articles[index].title, style: TextStyle(fontSize: 18)),
                              //   subtitle: Text(_articles[index].body, style: TextStyle(fontSize: 18)),
                              // );
                          },
                        );
                      },
                    ),
                )
              ],),
            )
          ],
        )
      );
  }
}

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState();
}