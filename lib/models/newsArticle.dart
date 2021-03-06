
import 'dart:convert';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';

class NewsArticle {
  
  final String title; 
  final String body; 
  final String url;
  final String published;
  final String officeName;
  final String officeId;
  final String short;
  final String highlight;

  NewsArticle({this.title, this.body, this.url, this.published, this.officeName,
  this.officeId, this.short, this.highlight});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    String officeName = '', officeId = '';
    if (json['office'] != null && json['office'].containsKey('name')) {
      officeName = json['office']['name'];
    }

    if (json['office'] != null && json['office'].containsKey('id')) {
      officeId = json['office']['name'];
    }
    return NewsArticle(
      title: json['title'], 
      body: json['body'], 
      url: json['url'] ?? '',
      published: json['published'] ?? '',
      officeName: officeName ?? '',
      officeId: officeId,
      highlight: json['highlight'] ?? '',
      short: json['short'] ?? '',
    );

  }

  Map<String, dynamic> toJson() => {'title': title, 'body': body, 'url':url, 'published': published,
  'officeName': officeName, 'officeId': officeId, 'short': short, 'highlight': highlight };

  static Resource<List<NewsArticle>> get all {
    
    return Resource(
      url: Constants.HEADLINE_NEWS_URL,
      parse: (response) {
        final result = json.decode(response.body); 
        if (result['success'] == "1") {
          Iterable list = result['content']['story'];
          return list.map((model) => NewsArticle.fromJson(model)).toList();
        } else {
          return null;
        }
      }
    );

  }

}