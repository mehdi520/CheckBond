import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:check_bond/infra/utils/utils_exports.dart';
import 'package:flutter/material.dart';

import '../../../../../../infra/configs/theme/app_colors.dart';
import '../../../../../common_widgets/text_ctl/text_exports.dart';

class BondItemWidget extends StatelessWidget {
  final UserBondDataModel data;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const BondItemWidget({
    super.key,
    required this.data,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.confirmation_number,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleMediumText(
                  contentText: data.bondNumber.padLeft(6, '0'),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                BodyMediumText(
                  contentText: 'Rs. 3434',
                  textColor: Colors.black87,
                ),
                const SizedBox(height: 4),
                BodyMediumText(
                  contentText: DateUtil.formatToDisplayDate(data.createdAt),
                  textColor: Colors.black54,
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 20,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}