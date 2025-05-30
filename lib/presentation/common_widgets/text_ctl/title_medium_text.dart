
import 'package:flutter/material.dart';

class TitleMediumText extends StatelessWidget {
  final String contentText;
  final TextStyle? textStyle;

  const TitleMediumText({
    super.key,
    required this.contentText,
    this.textStyle


  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.titleMedium;
    return Text(contentText,style: textStyle ?? defaultStyle);
  }
}
