import 'package:inauzwa/models/app_state.dart';
import 'package:inauzwa/models/product.dart';
import 'package:inauzwa/models/user.dart';
import 'package:inauzwa/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action)
  );
}

User  userReducer(User user, dynamic action) {
  if(action is GetUserAction) {
    // RETURN USER FROM ACTION
    return action.user;
  }
  return user;
}

List<Product>productsReducer(List<Product >products, dynamic action) {
  if (action is GetProductsAction) {
    return action.products;
  }

  return products;
}