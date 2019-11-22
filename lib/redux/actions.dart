import 'package:deinort_app/models/newsArticle.dart';
import 'package:deinort_app/models/location.dart';

class FetchArticlesAction {
  final List<NewsArticle> articles;

  FetchArticlesAction(this.articles);
}

class EmptyArticlesAction {
  EmptyArticlesAction();
}

class AddArticlesAction {
  final List<NewsArticle> articles;

  AddArticlesAction(this.articles);
}

class FetchLocationAction {
  final UserLocation location;

  FetchLocationAction(this.location);
}