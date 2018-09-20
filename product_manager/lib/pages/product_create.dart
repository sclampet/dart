import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;
  final Function deleteProduct;

  ProductCreatePage(this.addProduct, this.deleteProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleText;
  String _descriptionValue;
  double _productPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        //used a listview so if the keyboard covers a textfield we can scroll and still enter info there.
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Product Title'),
            onChanged: (String value) {
              setState(() {
                _titleText = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Description'),
            maxLines: 4,
            onChanged: (String value) {
              setState(() {
                _descriptionValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Price'),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              setState(() {
                _productPrice = double.parse(value);
              });
            },
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              final Map<String, dynamic> product = {
                'title': _titleText,
                'description': _descriptionValue,
                'price': _productPrice,
                'image': 'assets/pancakes.jpg',
              };
              widget.addProduct(product);
              Navigator.pushReplacementNamed(context, '/products');
            },
          ),
        ],
      ),
    );
  }
}
