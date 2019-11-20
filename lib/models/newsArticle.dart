
import 'dart:convert';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';

class NewsArticle {
  
  final String title; 
  final String body; 
  final String url; 

  NewsArticle({this.title, this.body, this.url});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {

    return NewsArticle(
      title: json['title'], 
      body: json['body'], 
      url: json['url'] ?? ''
    );

  }

  Map<String, dynamic> toJson() => {'title': title, 'body': body, 'url':url };

  static Resource<List<NewsArticle>> get all {
    
    return Resource(
      url: Constants.HEADLINE_NEWS_URL,
      parse: (response) {
        final result = json.decode(response.body); 
        Iterable list = result['content']['story'];
        return list.map((model) => NewsArticle.fromJson(model)).toList();
      }
    );

  }

}