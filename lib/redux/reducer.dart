import 'package:deinort_app/redux/state.dart';
import 'package:deinort_app/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) {
  if (action is FetchArticlesAction) {
    return fetchArticles(action);
  }
  return state;
}

AppState fetchArticles(FetchArticlesAction action) {
  print("TTTT: ");
  print(action);
  return AppState(action.articles);
}
