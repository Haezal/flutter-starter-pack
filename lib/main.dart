import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './config/config.dart';
import './providers/providers.dart';
import './views/views.dart';
import './models/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData = UserPreferences().getUser();

    return StreamProvider<DataConnectionStatus>(create: (_) {
      return DataConnectionChecker().onStatusChange;
    }, builder: (context, snapshot) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Starter Pack',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: FutureBuilder(
                future: getUserData,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    default:
                      if (snapshot.hasError)
                        return Center(child: Text('Error: ${snapshot.error}'));
                      else if (snapshot.data.token == null)
                        return LoginScreen();

                      Provider.of<UserProvider>(context, listen: false).setUser(snapshot.data);
                      return WelcomeScreen();
                  }
                }),
            routes: {
              '/login': (context) => LoginScreen(),
              '/welcome': (context) => WelcomeScreen(),
            }),
      );
    });
  }
}
