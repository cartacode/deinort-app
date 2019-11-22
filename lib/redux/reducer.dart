import 'package:deinort_app/redux/state.dart';
import 'package:deinort_app/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) {
  if (action is FetchArticlesAction) {
    return AppState(action.articles, state.location,false, state.error);
  } else if (action is EmptyArticlesAction) {
    return AppState(null, state.location,false, state.error);
  } else if (action is AddArticlesAction) {
    var newArticles = state.articles;

    if (action.articles != null) {
      if (state.articles != null) {
        newArticles = [state.articles, action.articles].expand((x) => x).toList();
      } else {
        newArticles = action.articles;
      }
    }

    return AppState(newArticles, state.location,false, state.error);
  } else if (action is FetchLocationAction) {
    return AppState(state.articles, action.location,false, state.error);
  } else if (action is ShowLoadingAction) {
    return AppState(state.articles, state.location, true, state.error);
  } else if (action is ErrorHanlderAction) {
    return AppState(state.articles, state.location, state.isLoading, action.error);
  }

  return state;
}
