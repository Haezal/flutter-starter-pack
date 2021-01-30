import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterpack/widgets/widgets.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
            child: InternetNotAvailable(),
          ),
          Expanded(
            child: Center(
              child: Text('Notification Page'),
            ),
          ),
        ],
      ),
    );
  }
}
