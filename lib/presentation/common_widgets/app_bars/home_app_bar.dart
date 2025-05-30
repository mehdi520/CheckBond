import 'package:check_bond/presentation/common_widgets/text_ctl/text_exports.dart';
import 'package:flutter/material.dart';

import '../../../infra/configs/config_exports.dart';
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TabController? tabController;
  
  const HomeAppBar({
    super.key, 
    this.title,
    this.tabController,
  });

  static const List<String> tabTitles = [
    'Check Bonds',
    'Observation',
    'Report',
    'Upload',
  ];

  @override
  Widget build(BuildContext context) {
    String displayTitle = title ?? "Safety Observation";
    if (tabController != null && tabController!.index >= 0 && tabController!.index < tabTitles.length) {
      displayTitle = tabTitles[tabController!.index];
    }
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      title: TitleLargeText(contentText: 'Check Bonds',textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: AppColors.white
      ),),
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: AppColors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: 'Menu',
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
