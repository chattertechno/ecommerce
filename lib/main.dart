import 'package:flutter/material.dart';
import 'package:inauzwa/models/app_state.dart';
import 'package:inauzwa/pages/cart_page.dart';
import 'package:inauzwa/pages/login.dart';
import 'package:inauzwa/pages/productspage.dart';
import 'package:inauzwa/pages/register.dart';
import 'package:inauzwa/redux/actions.dart';
import 'package:inauzwa/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Inauzwa',
          routes: {
            '/': (BuildContext context) => ProductsPage(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getProductsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getCartProductsAction);
                  // dispatch an action(getuseraction) to grab user data
                }),
            '/login': (BuildContext context) => LoginPage(),
            '/register': (BuildContext context) => RegisterPage(),
            '/cart': (BuildContext context) => CartPage(onInit: () {
              StoreProvider.of<AppState>(context).dispatch(getCardsAction);
            })
          },
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.cyan[400],
              accentColor: Colors.deepOrange,
              textTheme: TextTheme(
                  headline:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  body1: TextStyle(fontSize: 18.0))),
        ));
  }
}
