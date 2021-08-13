import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_sample/home/home_page.dart';

class SplashViewModel extends ChangeNotifier {
  startTimer(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    });
  }
}
