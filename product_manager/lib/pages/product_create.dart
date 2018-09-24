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
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/pancakes.jpg',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); //giving a key to a form - flutter gives access to the internal state of that form object

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'A title is required and should be 5+ characters long';
        }
      },
      //this method isn't called until currentState.save() is called - currently in when we are submitting the form.
      onSaved: (String value) {
          //no need to call setState because we just need to save the data not re-render the page for any reason.
          _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'A description is required and should be 10+ characters long';
        }
      },
      //this method isn't called until currentState.save() is called - currently in when we are submitting the form.
      onSaved: (String value) {
          //no need to call setState because we just need to save the data not re-render the page for any reason.
          _formData['desctription'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'A price is required and should be a number';
        }
      },
      //this method isn't called until currentState.save() is called - currently in when we are submitting the form.
      onSaved: (String value) {
          _formData['price'] = double.parse(value);
      },
    );
  }

  void _submitForm() {
    //run validator code once the use hits save. 'validate()' returns a bool
    if (!_formKey.currentState.validate()) {
      return;
    }
    //trigger all FormField onSaved methods
    _formKey.currentState.save();
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth -
        targetWidth; //calculates the amount of space that remains as opposed to the width of the entire form

    return GestureDetector(
      //register when the user taps anywhere but the keyboard
      onTap: () {
        //every TextField has an attached focus node that is used automatically when tapping it.
        //to remove the focus node and close the keyboard - pass an empty focus node (remove the focus node).
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
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
      ),
    );
  }
}
