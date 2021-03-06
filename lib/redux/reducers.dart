import 'package:inauzwa/models/app_state.dart';
import 'package:inauzwa/models/product.dart';
import 'package:inauzwa/models/user.dart';
import 'package:inauzwa/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      user: userReducer(state.user, action),
      products: productsReducer(state.products, action),
      cartProducts: cartProducts(state.cartProducts, action),
      cards: cardsReducer(state.cards, action)
      );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    // RETURN USER FROM ACTION
    return action.user;
  } else if (action is LogoutUserAction) {
    return action.user;
  }
  return user;
}

List<Product> productsReducer(List<Product> products, dynamic action) {
  if (action is GetProductsAction) {
    return action.products;
  }

  return products;
}

List<Product> cartProducts(List<Product> cartProducts, dynamic action) {
  if (action is GetCartProductsAction) {
    return action.cartProducts;
  } else if (action is ToggleCartProductAction) {
    return action.cartProducts;
  }
  return cartProducts;
}


List<dynamic> cardsReducer(List<dynamic> cards, dynamic action) {
  if (action is GetCardsAction) {
    return action.cards;
  }
  return cards;
}