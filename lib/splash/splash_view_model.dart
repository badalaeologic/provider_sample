import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider_sample/home/home_page.dart';
import 'dart:ui' as ui;
import 'package:share/share.dart' as share;

import '../save_image_file.dart';

class SplashViewModel extends ChangeNotifier {

  GlobalKey globalKey = GlobalKey();


  startTimer(BuildContext context) {
    // Timer(Duration(seconds: 3), () {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (context) => HomePage()),
    //       (route) => false);
    // });

    takeScreenShot();
  }


  takeScreenShot() async {
    try {
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1000));
      RenderRepaintBoundary boundary =
      globalKey
          .currentContext
          .findRenderObject();
      // if it needs repaint, we paint it.
      // if (boundary.debugNeedsPaint != null && boundary.debugNeedsPaint) {
      //   print('2');
      //   Timer(Duration(seconds: 1), () => takeScreenShot());
      //   print('2.1');
      //   return null;
      // }

      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();

      print('done');
      File file = await SaveImageFile.saveImageFromByte(pngBytes);
      print(file.path);
      share.Share.shareFiles([file.path],
          text:
          'For more news download News Café ${Platform.isIOS ? 'https://apps.apple.com/th/app/newscafe-latest-news-summary/id1451853143' : 'https://play.google.com/store/apps/details?id=co.cafenews.newscafe&hl=en'}');
      // if (Platform.isIOS) {
//        File file = await SaveImageFile.saveImageFromByte(pngBytes);
//        share.Share.shareFiles([file.path], text: 'Please Download news café ${Platform.isIOS ? 'https://apps.apple.com/th/app/newscafe-latest-news-summary/id1451853143' : 'https://play.google.com/store/apps/details?id=co.cafenews.newscafe&hl=en'}');
//       } else {
//         await Share.file('${newsList[currentNewPageValue.floor()].title}',
//             'newscafe.png', pngBytes.buffer.asUint8List(), 'image/png',
//             text:
//                 'Please Download news café ${Platform.isIOS ? 'https://apps.apple.com/th/app/newscafe-latest-news-summary/id1451853143' : 'https://play.google.com/store/apps/details?id=co.cafenews.newscafe&hl=en'}');
//       }
      notifyListeners();
    } catch (e) {
      print(e);
      print('error');
      notifyListeners();
    }
  }
}
