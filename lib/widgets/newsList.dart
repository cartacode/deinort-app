
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';

class NewsListState extends State<NewsList> {

  List<NewsArticle> _newsArticles = List<NewsArticle>();
  UserLocation _location = new UserLocation();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles(); 
  }

  Future<Map<String,dynamic>> _getLocation() {
    return Webservice().load(UserLocation.info).then((location) {
      return {
        'address': location.address
      };
      
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: ListView.builder(
          itemCount: _newsArticles.length,
          itemBuilder: _buildItemsForListView,
        )
      );
  }
}

class NewsList extends StatefulWidget {

  @override
  createState() => NewsListState(); 
}