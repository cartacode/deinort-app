import 'dart:isolate';

import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';

class AppState {
  final List<NewsArticle> articles;
  final UserLocation location;
  final bool isLoading;

  AppState(this.articles, this.location, this.isLoading);

  AppState.fromJson(Map<String, dynamic> json)
      : articles = (json['cartItems'] as List)
            .map((i) => new NewsArticle.fromJson(i as Map<String, dynamic>))
            .toList(),
        location = json['location']?? null,
        isLoading = json['isLoading'] ? true : false;

  Map<String, dynamic> toJson() => {'articles': articles, 'location': location, 'isLoading': isLoading};

  @override
  String toString() => "$articles";
}
