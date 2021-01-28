import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();

  FocusNode _usernameFocusNode, _passwordFocusNode = new FocusNode();

  String _username, _password;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      focusNode: _usernameFocusNode,
      autofocus: false,
      validator: validateEmail,
      // validator: (value) => value.isEmpty ? "Please enter email address" : null,
      onSaved: (value) => _username = value,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      decoration: buildInputDecoration("Confirm password", Icons.person, null),
    );

    final passwordField = TextFormField(
      focusNode: _passwordFocusNode,
      autofocus: false,
      obscureText: _obscureText,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(
        "Confirm password",
        Icons.lock,
        new GestureDetector(
            onTap: () {
              setState(() => _obscureText = !_obscureText);
            },
            child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.blueAccent)),
      ),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20.0,
          width: 20.0,
          child: CircularProgressIndicator(),
        ),
        Text(" Authenticating ... Please wait")
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();

        final Future<Map<String, dynamic>> loginMessage = auth.login(_username, _password);

        loginMessage.then((response) {
          // login successful
          if (response['success'] == true) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/main_screen');
          } else {
            Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              flushbarStyle: FlushbarStyle.FLOATING,
              reverseAnimationCurve: Curves.decelerate,
              forwardAnimationCurve: Curves.elasticOut,
              backgroundColor: Colors.red,
              boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)],
              backgroundGradient: LinearGradient(colors: [Colors.blueGrey, Colors.black]),
              isDismissible: false,
              duration: Duration(seconds: 3),
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.white,
              ),
              showProgressIndicator: false,
              progressIndicatorBackgroundColor: Colors.blueGrey,
              titleText: Text(
                "Login failed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red[600], fontFamily: "ShadowsIntoLightTwo"),
              ),
              messageText: Text(
                response['message'],
                style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
              ),
            ).show(context);
          }
        });
      } else {
        print('Form is invalid');
      }
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
                child: InternetNotAvailable(),
              ),
              SizedBox(height: 15.0),
              label('Email Address'),
              usernameField,
              SizedBox(height: 15.0),
              label('Password'),
              passwordField,
              SizedBox(height: 15.0),
              auth.loggedInStatus == Status.Authenticating ? loading : longButtons("Login", doLogin),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
