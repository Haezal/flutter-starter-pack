import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterpack/models/models.dart';
import 'package:starterpack/providers/user_provider.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  AnimationController _ColorAnimationController;

  // ignore: non_constant_identifier_names
  AnimationController _TextAnimationController;
  Animation _colorTween, _homeTween, _workOutTween, _iconTween, _drawerTween;

  @override
  void initState() {
    _ColorAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white).animate(_ColorAnimationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue.withOpacity(0.5)).animate(_ColorAnimationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_ColorAnimationController);
    _homeTween = ColorTween(begin: Colors.white, end: Colors.blue).animate(_ColorAnimationController);
    _workOutTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_ColorAnimationController);
    _TextAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 0));

    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  bool scrollListener(ScrollNotification scrollInfo) {
    bool scroll = false;
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 80);

      _TextAnimationController.animateTo(scrollInfo.metrics.pixels);
      return scroll = true;
    }
    return scroll;
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      key: scaffoldKey,
      // drawer: Drawer(),
      backgroundColor: Color(0xFFEEEEEE),
      body: NotificationListener<ScrollNotification>(
        onNotification: scrollListener,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 230,
                          color: Colors.blue,
                        ),
                        block1(),
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(top: 170, left: 16, right: 16),
                          color: Colors.white,
                          width: double.infinity,
                          height: 150,
                          child: Text('test'),
                        ),
                        Column(
                          children: <Widget>[
                            //ADD_MORE_WIDGETS
                            SizedBox(height: 300),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: 40,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  title: Text('test'),
                                );
                              },
                            ),
                          ],
                        ),
                        //ADD_MORE_WIDGETS
                      ],
                    ),
                  ),
                  AnimatedAppBar(
                    title: user.name,
                    drawerTween: _drawerTween,
                    onPressed: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                    colorAnimationController: _ColorAnimationController,
                    colorTween: _colorTween,
                    homeTween: _homeTween,
                    iconTween: _iconTween,
                    workOutTween: _workOutTween,
                  )
                ],
              ),
            ),
            //ADD_MORE_WIDGETS
          ],
        ),
      ),
    );
  }

  Widget block1() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '26',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total Bus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                '5',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Active Bus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
