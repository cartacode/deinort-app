import 'package:deinort_app/redux/state.dart';
import 'package:deinort_app/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) {
  if (action is FetchArticlesAction) {
    return AppState(action.articles, state.location);
  } else if (action is FetchLocationAction) {
    print("Action: ");
    print(action.location.city);
    return AppState(state.articles, action.location);
  }

  return state;
}
