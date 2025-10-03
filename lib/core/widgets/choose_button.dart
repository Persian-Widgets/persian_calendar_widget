import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n.dart';
import 'package:persian_calendar_widget/core/extension/scale_down_box.dart';

class ChooseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final double borderRadius;
  final String? title;
  final TextStyle? textStyle;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final I18n i18n;
  const ChooseButton({
    required this.onPressed,
    required this.buttonStyle,
    required this.borderRadius,
    required this.title,
    required this.textStyle,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.i18n,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 2,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              backgroundColor: onPrimaryColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                /// elevated button border radius fix by main box
                /// border radius value
                borderRadius: BorderRadius.circular(
                  borderRadius * 0.6,
                ),
              ),
            ),
        child: Text(
          title ?? i18n.buttons.submit,
          style: textStyle ??
              TextStyle(
                color: primaryColor,
              ),
        ).scaleDown,
      ),
    );
  }
}
