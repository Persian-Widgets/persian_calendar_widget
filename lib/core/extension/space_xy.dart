import 'package:flutter/material.dart';

extension SpaceXY on num {
  SizedBox get spaceX => SizedBox(width: toDouble());
  SizedBox get spaceY => SizedBox(height: toDouble());
}
