
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';

class NewsListState extends State<NewsList> {

  List<NewsArticle> _newsArticles = List<NewsArticle>();
  // var _location = new Location();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles(); 
  }

  Future<UserLocation> _getLocation() {
    return Webservice().load(UserLocation.info).then((location) {
      return location;
    });
  }

  void _populateNewsArticles() {
    String newsUrl;
    newsUrl = Constants.HEADLINE_NEWS_URL + '/region/' + 'sh' + Constants.NEWS_PARAMS;

    _getLocation().then((location) => {
      Webservice().loadByParams(newsUrl, NewsArticle.all).then((newsArticles) => {
        setState(() => {
          _newsArticles = newsArticles
        })
      })
    });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
      return ListTile(
        subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
      );
  }

  // Widget newsListWidget = Stack(
  //   children: <Widget>[
  //     Positioned(
  //       top: 0.0,
  //       child: Image.asset(
  //         'assets/google.jpg',
  //         fit: BoxFit.fill,
  //       ),
  //     ),
  //     Center(
  //       child: ListView.builder(
  //         itemCount: _newsArticles.length,
  //         itemBuilder: _buildItemsForListView,
  //       )
  //     ),
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: new Image.asset(
                'assets/google.jpg',
                width: size.width,
                height: size.height,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(top: 150.0),
              padding: const EdgeInsets.only(top: 10.0),
              color: Colors.blue,
              child: Stack(children: <Widget>[
                Text(
                  'Street1, Hemmingun',
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
                  child: ListView.builder(
                    itemCount: _newsArticles.length,
                    itemBuilder: _buildItemsForListView,
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