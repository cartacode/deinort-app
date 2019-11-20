import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';

class AppState {
  final List<NewsArticle> articles;
  final UserLocation location;

  AppState(this.articles, this.location);

  AppState.fromJson(Map<String, dynamic> json)
      : articles = (json['cartItems'] as List)
            .map((i) => new NewsArticle.fromJson(i as Map<String, dynamic>))
            .toList(),
        location = json['location']?? null;

  Map<String, dynamic> toJson() => {'articles': articles, 'location': location};

  @override
  String toString() => "$articles";
}
