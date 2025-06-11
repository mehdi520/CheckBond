import 'package:check_bond/data/models/bonds/data_model/won_bond_data_model.dart';
import 'package:check_bond/infra/utils/utils_exports.dart';
import 'package:flutter/material.dart';

import '../../../../../../infra/configs/theme/app_colors.dart';
import '../../../../../common_widgets/text_ctl/text_exports.dart';

class WonBondCard extends StatelessWidget {
  final WonBondDataModel data;
  final VoidCallback? onClaim;

  const WonBondCard({
    Key? key,
    required this.data,
    this.onClaim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: data.status == 'Pending' ? AppColors.warning : AppColors.success,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      data.status == 'Pending' ? Icons.pending_actions : Icons.check_circle,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data.status ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    data.position == 1 ? "1st" : (data.position == 2 ? "2nd" : "3rd"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BodySmallText(contentText: 'Bond Number'),
                        TitleMediumText(
                          contentText: data.bond.bondNumber,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        BodySmallText(
                          contentText: "Rs " + data.draw.bondType.toString(),
                          textStyle: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const BodySmallText(contentText: 'Amount Won'),
                        TitleMediumText(
                          contentText: 'Rs ${data.bond.bondType.toString()}',
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BodySmallText(contentText: 'Draw Number'),
                        TitleMediumText(
                          contentText: data.draw.drawNo.toString(),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const BodySmallText(contentText: 'Draw Place'),
                        TitleMediumText(
                          contentText: data.draw.place ?? '',
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    BodyMediumText(
                      contentText: DateUtil.formatToDisplayDate(data.draw.drawDate.toString()),
                      textColor: AppColors.textSecondary,
                    ),
                  ],
                ),
                if (onClaim != null) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onClaim,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Claim Bond'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }


} 