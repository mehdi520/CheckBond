
import 'package:flutter/material.dart';

import '../../../infra/configs/config_exports.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BasicAppBar({
    super.key,
  required this.title
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),

      title: Center(
        child: Text(title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.white,
          ),
       )
      ),
      actions: [


        SizedBox(
          width: 50,
        )
      ],
    );
  }

  @override
  Size get preferredSize  => const Size.fromHeight(kToolbarHeight);
}
