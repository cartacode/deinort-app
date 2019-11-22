import 'package:deinort_app/redux/state.dart';
import 'package:deinort_app/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) {
  if (action is FetchArticlesAction) {
    return AppState(action.articles, state.location);
  } else if (action is EmptyArticlesAction) {
    return AppState([], state.location);
  } else if (action is AddArticlesAction) {
    var newArticles = [state.articles, action.articles].expand((x) => x).toList();
    return AppState(newArticles, state.location);
  } else if (action is FetchLocationAction) {
    return AppState(state.articles, action.location);
  }

  return state;
}
