import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterpack/providers/auth.dart';
import 'package:starterpack/widgets/widgets.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var doLogout = () {
      AwesomeDialog(
        headerAnimationLoop: false,
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: doLogout,
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
            child: InternetNotAvailable(),
          ),
          Expanded(
            child: Center(
              child: Text('Menu Page'),
            ),
          ),
        ],
      ),
    );
  }
}
