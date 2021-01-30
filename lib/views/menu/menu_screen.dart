import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterpack/widgets/widgets.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
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
