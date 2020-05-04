import 'package:inauzwa/models/app_state.dart';

AppState appReducer(state, action) {
  return AppState(
    user: userReducer(state.user, action)
  );
}

userReducer(user, ation) {
  return user;
}