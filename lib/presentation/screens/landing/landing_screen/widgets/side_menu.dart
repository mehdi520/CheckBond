import 'package:check_bond/data/data_sources/local/hive_manager.dart';
import 'package:check_bond/data/models/user/data_model/user_model.dart';
import 'package:check_bond/presentation/screens/landing/landing_screen/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';

import '../../../../../infra/configs/config_exports.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? loggedInUser = HiveManager.getUserJson();

    void _handleLogout(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              'Are you sure you want to logout?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  HiveManager.clearUserData();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.loginRoute,
                    (route) => false,
                  );
                },
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.white.withOpacity(0.2),
                                child: Text(
                                  loggedInUser?.name?.substring(0, 1).toUpperCase() ?? 'U',
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loggedInUser?.name ?? 'User',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    loggedInUser?.email ?? '',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // My Account
                  SideMenuItem(
                    icon: Icons.person_outline,
                    title: 'My Account',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRoutes.accRoute);
                    },
                  ),
                  SideMenuItem(
                    icon: Icons.category_outlined,
                    title: 'Bond Summary',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRoutes.bondSummaryRoute);
                    },
                  ),

                  // // Category
                  // SideMenuItem(
                  //   icon: Icons.category_outlined,
                  //   title: 'Category',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, AppRoutes.categoryRoute);
                  //   },
                  // ),
                  // // Income
                  // SideMenuItem(
                  //   icon: Icons.arrow_upward,
                  //   title: 'Income',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, AppRoutes.incomeRoute);
                  //   },
                  // ),
                  // // Expense
                  // SideMenuItem(
                  //   icon: Icons.arrow_downward,
                  //   title: 'Expense',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.pushNamed(context, AppRoutes.expenseRoute);
                  //   },
                  // ),
                  // Change Password
                  SideMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRoutes.chnagePassRoute);
                    //  Navigator.pushNamed(context, AppRoutes.changePasswordRoute);
                    },
                  ),
                  // Logout
                  SideMenuItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () => _handleLogout(context),
                    textColor: AppColors.error,
                    iconColor: AppColors.error,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Version 1.0',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
