import 'package:flutter/material.dart';

extension ToPersianDigit on String? {
  String toPersianDigit() {
    String? result = this;

    if (result == null) {
      return '';
    } else {
      result = result.replaceAll('0', '۰');
      result = result.replaceAll('1', '۱');
      result = result.replaceAll('2', '۲');
      result = result.replaceAll('3', '۳');
      result = result.replaceAll('4', '۴');
      result = result.replaceAll('5', '۵');
      result = result.replaceAll('6', '۶');
      result = result.replaceAll('7', '۷');
      result = result.replaceAll('8', '۸');
      result = result.replaceAll('9', '۹');

      return result;
    }
  }
}

extension PersianTextExtension on Text {
  Text withPersianDigits() {
    final String? originalText = data;
    final String convertedText = originalText?.toPersianDigit() ?? '';

    return Text(
      convertedText,
      key: key,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      selectionColor: selectionColor,
      semanticsIdentifier: semanticsIdentifier,
      textScaler: textScaler,
    );
  }
}
