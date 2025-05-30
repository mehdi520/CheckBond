import 'package:check_bond/presentation/common_widgets/text_ctl/text_exports.dart';
import 'package:flutter/material.dart';

class MyBondsScreens extends StatelessWidget {
  const MyBondsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [

          TitleLargeText(contentText: 'Title Large text'),
          TitleMediumText(contentText: 'Title Medium text'),
          TitleSmallText(contentText: 'Title Small text'),
          BodyLargeText(contentText: 'Body Large text'),
          BodyMediumText(contentText: 'Body Medium text'),
          BodySmallText(contentText: 'Body Small text'),
        ],
      ),
    );
  }
}
