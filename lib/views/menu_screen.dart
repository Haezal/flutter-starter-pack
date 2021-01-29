import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/common.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context).user;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var doLogout = () {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Logout',
        desc: 'Are you sure?',
        btnCancelOnPress: () {},
        btnOkText: 'Proceed',
        btnOkOnPress: () {
          auth.logout();
          Navigator.pushReplacementNamed(context, '/login');
        },
      )..show();

    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(user.name),
              SizedBox(height:15),
              Text(user.email),
              SizedBox(height:15),
              longButtons('Logout', doLogout),
            ],
          ),
        ),
      ),
    );
  }
}
