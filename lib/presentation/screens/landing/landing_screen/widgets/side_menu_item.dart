
import 'package:flutter/material.dart';

import '../../../../../infra/configs/config_exports.dart';

class SideMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const SideMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppColors.cardShadow,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: iconColor ?? AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: textColor ?? AppColors.textSecondary,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: (iconColor ?? AppColors.textSecondary).withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}