import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterpack/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
            child: InternetNotAvailable(),
          ),
          Expanded(
            child: Center(
              child: Text('Welcome Page'),
            ),
          ),
        ],
      ),
    );
  }
}
