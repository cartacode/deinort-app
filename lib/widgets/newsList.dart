
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';
import 'package:deinort_app/redux/state.dart';
import 'package:deinort_app/redux/actions.dart';
import 'package:redux_thunk/redux_thunk.dart';

class NewsListState extends State<NewsList> {

  List<NewsArticle> _newsArticles = List<NewsArticle>();
  // var _location = new Location();

  @override
  void initState() {
    super.initState();
  }

  // ListTile _buildItemsForListView(BuildContext context, int index) {
  //     return ListTile(
  //       title: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
  //       subtitle: Text(_newsArticles[index].body, style: TextStyle(fontSize: 18)),
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: Stack(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image.asset(
                  'assets/google.jpg',
                  width: 70,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a search key'
                  ),
                );
              ]
            ),
            Center(
              child: new Image.asset(
                'assets/google.jpg',
                width: size.width,
                height: size.height,
                fit: BoxFit.fill
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(top: 150.0),
              padding: const EdgeInsets.only(top: 10.0),
              color: Colors.blue,
              child: Stack(children: <Widget>[
                Text(
                  'Street11, Hemmingun',
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 40,
                    right: 10,
                    bottom: 10,
                    left: 10),
                  color: Color(0xFFFFFFFF),
                  child: StoreConnector<AppState, List<NewsArticle>>(
                    converter: (store) {
                      return store.state.articles;
                    },
                      builder: (_, _articles) {
                        return ListView.builder(
                          itemCount: _articles.length,
                          itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(_articles[index].title, style: TextStyle(fontSize: 18)),
                                subtitle: Text(_articles[index].body, style: TextStyle(fontSize: 18)),
                              );
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