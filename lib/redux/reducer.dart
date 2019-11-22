import 'package:deinort_app/redux/state.dart';
import 'package:deinort_app/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) {
  if (action is FetchArticlesAction) {
    return AppState(action.articles, state.location);
  } else if (action is EmptyArticlesAction) {
    return AppState(null, state.location);
  } else if (action is AddArticlesAction) {
    var newArticles = state.articles;

    if (action.articles != null) {
      if (state.articles != null) {
        newArticles = [state.articles, action.articles].expand((x) => x).toList();
      } else {
        newArticles = action.articles;
      }
    }

    return AppState(newArticles, state.location);
  } else if (action is FetchLocationAction) {
    return AppState(state.articles, action.location);
  }

  return state;
}
