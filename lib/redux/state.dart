import 'dart:isolate';

import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';

class AppState {
  final List<NewsArticle> articles;
  final UserLocation location;
  final bool isLoading;
  final String error;

  AppState(this.articles, this.location, this.isLoading, this.error);

  AppState.fromJson(Map<String, dynamic> json)
      : articles = (json['cartItems'] as List)
            .map((i) => new NewsArticle.fromJson(i as Map<String, dynamic>))
            .toList(),
        location = json['location']?? null,
        isLoading = json['isLoading'] ? true : false,
        error = json['error'] ? json['error'] : null;

  Map<String, dynamic> toJson() => {'articles': articles, 'location': location,
                                  'isLoading': isLoading, 'error': error};

  @override
  String toString() => "$articles";
}
