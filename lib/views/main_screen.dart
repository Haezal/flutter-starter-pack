import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Column(
        children: [
          Visibility(
              visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
              child: InternetNotAvailable()),
          Center(
            child: Text('Content'),
          ),
        ],
      ),
    );
  }
}
