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

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Title'),
      onChanged: (String value) {
        setState(() {
          _titleText = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      onChanged: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        setState(() {
          _productPrice = double.parse(value);
        });
      },
    );
  }

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': _titleText,
      'description': _descriptionValue,
      'price': _productPrice,
      'image': 'assets/pancakes.jpg',
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth -
        targetWidth; //calculates the amount of space that remains as opposed to the width of the entire form

    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView( //used a listview so if the keyboard covers a textfield we can scroll and still enter info there.
        padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildPriceTextField(),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: _submitForm,
          ),
          // GestureDetector( //use this if you need more control over a button
          //   onTap: _submitForm,
          //   child: Container(
          //     color: Colors.green,
          //     padding: EdgeInsets.all(10.0),
          //     child: Text('Button'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
