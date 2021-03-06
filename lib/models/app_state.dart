import 'package:inauzwa/models/product.dart';
import 'package:inauzwa/models/user.dart';
import 'package:meta/meta.dart';
@immutable

class AppState {
  final User user;

  final List<Product> products;
  final List<Product> cartProducts;
  final List<dynamic> cards;

  AppState({ @required this.user, @required this.products, @required this.cartProducts, @required this.cards });

  factory AppState.initial() {
    return AppState(
      user: null,
      products: [],
      cartProducts: [],
      cards: []
    );
  }
}