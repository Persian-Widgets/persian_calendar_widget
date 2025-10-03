import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n.dart';
import 'package:persian_calendar_widget/core/extension/scale_down_box.dart';

class CancelButton extends StatelessWidget {
  final ButtonStyle? buttonStyle;
  final double borderRadius;
  final String? title;
  final TextStyle? textStyle;
  final Color? primaryColor;
  final I18n i18n;
  const CancelButton({
    required this.buttonStyle,
    required this.borderRadius,
    required this.title,
    required this.textStyle,
    required this.primaryColor,
    required this.i18n,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                /// text button border radius fix by main box border
                /// radius value
                borderRadius: BorderRadius.circular(
                  borderRadius * 0.6,
                ),
              ),
            ),
        child: Text(
          title ?? i18n.buttons.cancel,
          style: textStyle ?? TextStyle(color: primaryColor),
        ).scaleDown,
      ),
    );
  }
}
