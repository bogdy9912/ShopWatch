import 'package:flutter/material.dart';
import 'package:shop_watch/size_config.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFunction;

  AuthForm(this.submitFunction);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userPassword = '';
  String _userName = '';
  String _confirmPassword = '';

  void _trySubmit() {
    bool _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState.save();
      // functia de trimitere catre baza de date a inputurilor
      widget.submitFunction(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.12,
            ),
            Text(
              'Welcome back',
              style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.18,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: ValueKey('email'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@'))
                            return ' Please enter a valid email!';
                          return null;
                        },
                        onSaved: (newValue) {
                          _userEmail = newValue;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                          autocorrect: true,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value.isEmpty || value.length < 3)
                              return 'Your username is to short!';
                            return null;
                          },
                          onSaved: (newValue) {
                            _userName = newValue;
                          },
                        ),
                      TextFormField(
                        key: ValueKey('password'),
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty || value.length < 7)
                            return 'Your password is to short!';
                          return null;
                        },
                        onChanged: (value) {
                          _userPassword = value;
                        },
                        /*
                        onFieldSubmitted: (value) {
                          _userPassword = value;
                        },*/
                        onSaved: (newValue) {
                          _userPassword = newValue;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('confirmPassword'),
                          decoration: InputDecoration(
                            labelText: 'Confirm password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value != _userPassword)
                              return 'Passwords don\'t coincide';
                          },
                          onSaved: (newValue) {
                            _confirmPassword = newValue;
                          },
                        ),
                      SizedBox(
                        height: 12,
                      ),
                      RaisedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'Sign up'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      FlatButton(
                        textColor: Colors.grey[300],
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: FittedBox(
                          child: Text(_isLogin
                              ? 'You don\'t have an account? Register here!'
                              : 'I already have an account'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
