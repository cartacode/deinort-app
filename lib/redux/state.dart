import 'package:deinort_app/models/newsArticle.dart';

class AppState {
  static var empty = AppState(new List());

  final List<NewsArticle> articles;

  AppState(this.articles);

  AppState.fromJson(Map<String, dynamic> json)
      : articles = (json['cartItems'] as List)
            .map((i) => new NewsArticle.fromJson(i as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {'articles': articles};

  @override
  String toString() => "$articles";
}
