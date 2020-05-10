import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inauzwa/models/app_state.dart';
import 'package:inauzwa/widgets/products_item.dart';

class CartPage extends StatefulWidget {
  final void Function() onInit;
  CartPage({this.onInit});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    Widget _cartTab() {
      final Orientation orientation = MediaQuery.of(context).orientation;
      return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Column(
            children: <Widget>[
              Expanded(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: GridView.builder(
                      itemCount: state.cartProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            orientation == Orientation.portrait ? 2 : 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemBuilder: (context, index) =>
                          ProductItem(item: state.cartProducts[index])),
                ),
              )
            ],
          );
        },
      );
    }

    Widget _cardsTab() {
      return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10.0)),
              RaisedButton(
                elevation: 8.0,
                child: Text('Add Card'),
                onPressed: () => print('Pressed')
              ),

              Expanded(
                child: ListView(
                  children: state.cards.map<Widget>(
                    (card) => (ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        child: Icon(
                          Icons.credit_card,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("${card['exp_month']}/${card['exp_year']}, ${card['last4']}"),
                      subtitle: Text(card['brand']),
                      trailing: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Text('set as Primary', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink)),
                        onPressed: () => print('pressed')
                      )
                    ))
                  ).toList()
                ),
              )
            ],
          );
        },
      );
    }

    Widget _ordersTab() {
      return Text('cart');
    }

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('cart page'),
          bottom: TabBar(
            labelColor: Colors.deepOrange[600],
            unselectedLabelColor: Colors.deepOrange[900],
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.shopping_cart),
              ),
              Tab(
                icon: Icon(Icons.credit_card),
              ),
              Tab(
                icon: Icon(Icons.receipt),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[_cartTab(), _cardsTab(), _ordersTab()],
        ),
      ),
    );
  }
}
