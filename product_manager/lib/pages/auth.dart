import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          //used a listview so if the keyboard covers a textfield we can scroll and still enter info there.
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setState(() {
                  _emailValue = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (String value) {
                setState(() {
                  _passwordValue = value;
                });
              },
            ),
            SwitchListTile(
              value: _acceptTerms,
              onChanged: (bool val) {
                setState(() {
                  _acceptTerms = val;
                });
              },
              title: Text('Accept Terms'),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('LOGIN'),
              onPressed: () {
                print(_emailValue + _passwordValue);
                Navigator.pushReplacementNamed(context, '/products');
              },
            ),
          ],
        ),
      ),
    );
  }
}
