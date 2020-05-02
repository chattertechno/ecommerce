import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  bool _obscureText = true;

  String  _email, _password;

  void _submit() {
  final form = _formkey.currentState;

  if (form.validate()) {
    form.save();
    print('Email: $_email, Password: $_password');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text('Login', style: Theme.of(context).textTheme.headline,),
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
                    validator: (val) => val.length < 6 ? 'PASSWORD too short': null,                    
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
                      hintText: 'Enter Your Password to Login',
                      icon: Icon(Icons.lock, color: Colors.grey,)
                    ),
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          child: Text('Submit', style: Theme.of(context).textTheme.body1.copyWith(color: Colors.deepOrange),),
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: _submit,
                        ),
                        FlatButton(
                          child: Text('New user? Register'),
                          onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                        )
                      ],
                    ),
                  )
                ],


              ),
            ),
          ),
        ),
      ),

    );
  }
}

