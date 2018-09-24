import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart'; //for debugging

import './pages/products_admin.dart';
import './pages/product.dart';
import './pages/products.dart';
import './pages/auth.dart';

void main() {
  // debugPaintSizeEnabled = true; //shows components in blue border
  // debugPaintPointersEnabled = true; //tap highlighting
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true, //red grid across entire app
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange, //swatch - because other colors are derived from it 
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepPurple,
          ),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(_products),
        '/admin': (BuildContext context) =>
            ProductsAdminPage(_addProduct, _deleteProduct, _products)
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          //if path doesn't start with a '/' return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);

          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                  _products[index]['title'],
                  _products[index]['image'],
                  _products[index]['price'],
                  _products[index]['description'],
                ),
          );
        }
        return null;
      },
      //if generateRoute fails this will run. Play it safe! :)
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductsPage(_products),
        );
      },
    );
  }
}
