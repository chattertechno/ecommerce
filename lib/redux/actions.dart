import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inauzwa/models/app_state.dart';
import 'package:inauzwa/models/product.dart';
import 'package:inauzwa/models/user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* User action */

ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  store.dispatch(GetUserAction(user));
};

class GetUserAction {
  final User _user;

  User get user => this._user;

  GetUserAction(this._user);
}

/* products action */

ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  http.Response response =
      await http.get('http://192.168.10.133:1337/products');
  final List<dynamic> responseData = json.decode(response.body);
  List<Product> products = [];
  responseData.forEach((productData) {
    final Product product = Product.fromJson(productData);
    products.add(product);
  });
  store.dispatch(GetProductsAction(products));
};

ThunkAction<AppState> logoutUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  User user;
  store.dispatch(LogoutUserAction(user));
};

class GetProductsAction {
  final List<Product> _products;

  List<Product> get products => this._products;

  GetProductsAction(this._products);
}

class LogoutUserAction {
  final User _user;

  User get user => this._user;

  LogoutUserAction(this._user);
}

/* cart products action */
ThunkAction<AppState> toggleCartProductAction(Product cartProduct) {
  return (Store<AppState> store) async  {
    final List<Product> cartProducts = store.state.cartProducts;
    final User user = store.state.user;
    final int index =
        cartProducts.indexWhere((product) => product.id == cartProduct.id);
    bool isInCart = index > -1 == true;
    List<Product> updatedCartProducts = List.from(cartProducts);
    if (isInCart) {
      updatedCartProducts.removeAt(index);
    } else {
      updatedCartProducts.add(cartProduct);
    }
    final List<String> cartProductsIds = updatedCartProducts.map((product) => product.id).toList();
    await http.put('http://192.168.10.133:1337/carts/${user.cartId}', body: {
      "products": json.encode(cartProductsIds)
    }, headers: {
      "Authorization": "Bearer ${user.jwt}"
    });
    store.dispatch(ToggleCartProductAction(updatedCartProducts));
  };
}

ThunkAction<AppState> getCartProductsAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  if (storedUser == null) {
    return;
  } 
  final User user = User.fromJson(json.decode(storedUser));
  http.Response response = await http.get('http://192.168.10.133:1337/carts/${user.cartId}', headers: {
    'Authorization': 'Bearer ${user.jwt}'
  });
  final responseData = json.decode(response.body)['products'];
  List<Product> cartProducts = [];
  responseData.forEach((productData) {
    final Product product = Product.fromJson(productData);
    cartProducts.add(product);
  });
  store.dispatch(GetCartProductsAction(cartProducts));
};

class GetCartProductsAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  GetCartProductsAction(this._cartProducts);
}


class ToggleCartProductAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  ToggleCartProductAction(this._cartProducts);
}

/* Cards actiom */

ThunkAction<AppState> getCardsAction = (Store<AppState> store) async {
  final String customerId = store.state.user.customerId;
  http.Response response = await http.get('http://192.168.10.133:1337/card?$customerId');
  final responseData = json.decode(response.body);
  // print('card Data : $responseData');
  store.dispatch(GetCardsAction(responseData));

};

class GetCardsAction {
  List<dynamic> _cards;

  List<dynamic> get cards => this._cards;

  GetCardsAction(this._cards);
}