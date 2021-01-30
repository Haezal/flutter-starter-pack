import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterpack/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
              child: InternetNotAvailable(),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Select your route'),
                  SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
