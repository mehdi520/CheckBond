
import 'package:flutter/material.dart';

class TitleLargeText extends StatelessWidget {
  final String contentText;
  final TextStyle? textStyle;

  const TitleLargeText({
    super.key,
    required this.contentText,
    this.textStyle


  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.titleLarge;
    return Text(contentText,style: textStyle ?? defaultStyle);
  }
}
