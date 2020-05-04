
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inauzwa/models/app_state.dart';
import 'package:inauzwa/widgets/products_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.1, 0.3, 0.5, 0.7, 0.9],
    colors: [
      Colors.deepOrange[300],
      Colors.deepOrange[400],
      Colors.deepOrange[500],
      Colors.deepOrange[600],
      Colors.deepOrange[700]
    ]
  )
);

class ProductsPage extends StatefulWidget {
  final void Function () onInit;
  ProductsPage({ this.onInit });

  @override

  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  void initState() {
    super.initState();
    widget.onInit();

    
  }

  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: SizedBox(child: state.user != null ? Text(state.user.username) : Text(''),),
          leading: Icon(Icons.store),
          actions: <Widget>[
            Padding(padding: EdgeInsets.only(right: 12.0),
            child: state.user != null ? IconButton(icon: Icon(Icons.exit_to_app),
            onPressed: () => print('pressed')) : Text(''),
            )
          ],
        );
      },
    ),
  );

  int index = 0;
  
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: _appBar,
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) { setState(() {
          this.index = index;
        });
        },
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(icon: new Icon(Icons.home),
          title: new Text('Home'),
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.shop),
          title: Text('Shop',)
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.search),
          title: Text('track')
          )
        ],
      ),
      body: Container(
        decoration: gradientBackground,
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Column(children: <Widget>[
              Expanded(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: GridView.builder(
                    itemCount: state.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemBuilder: (context, index) => ProductItem(item: state.products[index])
                  ),
                ),
              )
            ],);
          },
        )
      ),
    );
  }
}