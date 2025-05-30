
import 'package:flutter/material.dart';

class BodyLargeText extends StatelessWidget {
  final String contentText;
  final TextStyle? textStyle;
  const BodyLargeText({
    super.key,
    required this.contentText,
    this.textStyle

  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyLarge;
    return Text(contentText,style: textStyle ?? defaultStyle);
  }
}
