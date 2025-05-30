
import 'package:flutter/material.dart';

class BodySmallText extends StatelessWidget {
  final String contentText;
  final TextStyle? textStyle;

  const BodySmallText({
    super.key,
    required this.contentText,
    this.textStyle


  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodySmall;
    return Text(contentText,style: textStyle ?? defaultStyle);
  }
}
