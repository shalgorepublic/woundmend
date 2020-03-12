import 'dart:io';

import 'package:flutter/material.dart';

class UvIndex {
  final dynamic uvIndex;
  final String time;


  UvIndex({
    @required this.uvIndex,
    @required this.time,
  });

}
class ImageData {
  final File image;
  final String message;


  ImageData({
    @required this.image,
    @required this.message,
  });

}