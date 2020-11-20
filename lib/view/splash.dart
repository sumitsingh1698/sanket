import 'package:flutter/material.dart';

import 'homepage_view.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomepageView()),
          (route) => false);
    });

    return Container(
        color: Theme.of(context).primaryColor,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "S",
              style: TextStyle(
                fontSize: 70,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            Text(
              "anket",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        )));
  }
}
