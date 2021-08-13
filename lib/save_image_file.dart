import 'dart:async';
import 'dart:io' as Io;
import 'dart:ui';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class SaveImageFile {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<Io.File> getImageFromNetwork(String url) async {
    Io.File file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }

  static Future<Io.File> saveImage(String url) async {
    final file = await getImageFromNetwork(url);
    //retrieve local path for device
    var path = await _localPath;
    print(path);
    Image image = decodeImage(file.readAsBytesSync());

    // Save the thumbnail as a PNG.
    return new Io.File('$path/${DateTime.now().toUtc().toIso8601String()}.png')
      ..writeAsBytesSync(encodePng(image));
  }

  static Future<Io.File> saveImageFromByte(var pngBytes) async {

    var path = await _localPath;
    print(path);

    Image image = decodeImage(pngBytes);
    // Save the thumbnail as a PNG.
    return new Io.File('$path/${DateTime.now().toUtc().toIso8601String()}.png')
      ..writeAsBytesSync(encodePng(image));
  }
}
