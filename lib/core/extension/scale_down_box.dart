import 'package:flutter/material.dart';

extension ScaleDownBox on Text {
  FittedBox get scaleDown => FittedBox(
        fit: BoxFit.scaleDown,
        child: this,
      );
}
