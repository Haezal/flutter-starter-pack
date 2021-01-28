import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../models/models.dart';

class WelcomeScreen extends StatefulWidget {

  WelcomeScreen({Key key}): super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context).user;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var doLogout = () {
      auth.logout();
      Navigator.pushReplacementNamed(context, '/login');
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: doLogout),
        ],
      ),
      body: Center(
        child: Text('Welcome page ${user.name}'),
      ),
    );
  }
}
