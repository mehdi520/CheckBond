
import 'package:flutter/material.dart';

class TitleSmallText extends StatelessWidget {
  final String contentText;
  final TextStyle? textStyle;

  const TitleSmallText({
    super.key,
    required this.contentText,
    this.textStyle


  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.titleSmall;
    return Text(contentText,style: textStyle ?? defaultStyle);
  }
}
