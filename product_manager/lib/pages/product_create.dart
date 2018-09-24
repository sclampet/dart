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
  final GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); //giving a key to a form - flutter gives access to the internal state of that form object

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      autovalidate: true,
      validator: (String value) {
        if(value.isEmpty || value.length < 5) {
          return 'A title is required and should be 5+ characters long';
        }
      },
      //this method isn't called until currentState.save() is called - currently in when we are submitting the form.
      onSaved: (String value) {
        setState(() {
          _titleText = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      validator: (String value) {
        if(value.isEmpty || value.length < 10) {
          return 'A description is required and should be 10+ characters long';
        }
      },
      //this method isn't called until currentState.save() is called - currently in when we are submitting the form.
      onSaved: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if(value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'A price is required and should be a number';
        }
      },
      //this method isn't called until currentState.save() is called - currently in when we are submitting the form.
      onSaved: (String value) {
        setState(() {
          _productPrice = double.parse(value);
        });
      },
    );
  }

  void _submitForm() {
    //run validator code once the use hits save. 'validate()' returns a bool
    if(!_formKey.currentState.validate()) {
      return;
    }
    //trigger all FormField onSaved methods
    _formKey.currentState.save();
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
      child: Form(
        key: _formKey,
        child: ListView(
          //used a listview so if the keyboard covers a textfield we can scroll and still enter info there.
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
      ),
    );
  }
}
