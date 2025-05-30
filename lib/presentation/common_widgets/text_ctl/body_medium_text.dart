
import 'package:flutter/material.dart';

class BodyMediumText extends StatelessWidget {
  final String contentText;
  final TextStyle? textStyle;
  final Color? textColor;

  const BodyMediumText({
    super.key,
    required this.contentText,
    this.textStyle,
    this.textColor


  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium;
    return Text(contentText,style: (textStyle ?? defaultStyle)?.copyWith(
      color: textColor ?? textStyle?.color ?? defaultStyle?.color
    ));
  }
}
