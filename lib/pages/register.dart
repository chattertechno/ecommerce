import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  
  bool _isSubmitting, _obscureText = true;

  String _username, _email, _password;

  void _submit() {
  final form = _formkey.currentState;

  if (form.validate()) {
    form.save();
    _registerUser();
  }
}



void _registerUser() async {
  setState(() => _isSubmitting = true);
  http.Response response = await http.post('http://192.168.10.133:1337/auth/local/register', 
  body: {
    "username": _username,
    "email": _email,
    "password": _password,

  });
  final responseData = json.decode(response.body);
  if (response.statusCode == 200) {
  setState(() => _isSubmitting = false);
  _storeUserData(responseData);
  _showSuccessSnack();
  _redirectUser();
  print(responseData);
  } else {
     setState(() => _isSubmitting = false);
     final String errorMsg = responseData['message'];
    _showErrorSnack(errorMsg);
  }
}

void _storeUserData(responseData) async {
 final prefs = await SharedPreferences.getInstance();
 Map<String, dynamic> user = responseData['user'];
 user.putIfAbsent('jwt', () => responseData['jwt']);
 prefs.setString('user', json.encode(user));
 
}

void _showSuccessSnack() {
  final snackbar = SnackBar(
    content: Text('User $_username successfull created', style: TextStyle(color: Colors.green),),
  );
  _scaffoldkey.currentState.showSnackBar(snackbar);
  _formkey.currentState.reset();
}

void _showErrorSnack(String errorMsg) {
  final snackbar = SnackBar(
    content: Text(errorMsg, style: TextStyle(color: Colors.red),),
  );
  _scaffoldkey.currentState.showSnackBar(snackbar);
  throw Exception('Error Registering: $errorMsg');
}

void _redirectUser() {
  Future.delayed(Duration(seconds: 2), () {
  Navigator.pushReplacementNamed(context, '/');
  });
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('REGISTER'),
        
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text('Register', style: Theme.of(context).textTheme.headline,),
                  Padding(padding: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    onSaved: (val) => _username=val,
                    validator: (val) => val.length < 6 ? 'Username too short': null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter Username to Register',
                      icon: Icon(Icons.face, color: Colors.grey,)
                    ),
                  ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    onSaved: (val) => _email=val,
                    validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Email Password',
                      icon: Icon(Icons.email, color: Colors.grey,)
                    ),
                  ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    obscureText: _obscureText,
                    onSaved: (val) => _password=val,
                    validator: (val) => val.length < 6 ? 'Password too short': null,                    
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                        child: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off),
                      ),                
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Your Password to Register',
                      icon: Icon(Icons.lock, color: Colors.grey,)
                    ),
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        _isSubmitting == true ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),) : RaisedButton(
                          child: Text('Submit', style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black),),
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: _submit,
                        ),
                        FlatButton(
                          child: Text('Existing user? Login'),
                          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                        )
                      ],
                    ),
                  ),
                ],


              ),
            ),
          ),
        ),
      ),

    );
  }
}

