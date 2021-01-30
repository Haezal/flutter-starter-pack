import 'package:flutter/material.dart';

class AnimatedAppBar extends StatelessWidget {
  final AnimationController colorAnimationController;
  final Animation colorTween, homeTween, workOutTween, iconTween, drawerTween;
  final String title;
  final Function onPressed;

  AnimatedAppBar({
    @required this.colorAnimationController,
    @required this.onPressed,
    @required this.colorTween,
    @required this.homeTween,
    @required this.iconTween,
    @required this.drawerTween,
    @required this.workOutTween,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: AnimatedBuilder(
        animation: colorAnimationController,
        builder: (context, child) => AppBar(
          backgroundColor: colorTween.value,
          elevation: 0.0,
          titleSpacing: 0.0,
          title: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Text(
                "Hi, ",
                style: TextStyle(color: homeTween.value, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
              ),
              Expanded(
                child: Text(
                  title ?? '- no name -',
                  style: TextStyle(color: workOutTween.value, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7),
              child: Icon(
                Icons.notifications,
                color: iconTween.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
