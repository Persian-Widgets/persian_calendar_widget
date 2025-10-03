import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/extension/scale_down_box.dart';
import 'package:persian_calendar_widget/core/extension/to_persian_digit.dart';

class TypeDataButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final ButtonStyle? selectedButtonStyle;
  final String title;
  final bool isSelected;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final Color? onPrimaryColor;
  final Color? primaryColor;
  final bool enablePersianDigits;
  const TypeDataButton({
    required this.onPressed,
    required this.buttonStyle,
    required this.selectedButtonStyle,
    required this.title,
    required this.isSelected,
    required this.textStyle,
    required this.selectedTextStyle,
    required this.onPrimaryColor,
    required this.primaryColor,
    required this.enablePersianDigits,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: TextButton(
        onPressed: onPressed,
        style: buttonStyle == null
            ? TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: isSelected
                    ? onPrimaryColor ??
                        Theme.of(context).scaffoldBackgroundColor
                    : Colors.transparent,
              )
            : isSelected
                ? selectedButtonStyle ?? buttonStyle
                : buttonStyle,
        child: Text(
          title,
          style: textStyle == null
              ? TextStyle(
                  color: isSelected
                      ? primaryColor ?? Theme.of(context).primaryColor
                      : onPrimaryColor ?? Colors.white,
                )
              : isSelected
                  ? selectedTextStyle ?? textStyle
                  : textStyle,
        ).withPersianDigits(enable: enablePersianDigits).scaleDown,
      ),
    );
  }
}
