import 'package:check_bond/data/models/bonds/data_model/sch_bond_data_model.dart';
import 'package:check_bond/infra/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../../../../infra/configs/config_exports.dart';
import '../../../common_widgets/text_ctl/text_exports.dart';

class ItemSchBond extends StatelessWidget {
  final SchBondDataModel data;
  const ItemSchBond({super.key, required this.data});

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
              Icons.event,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TitleMediumText(contentText: 'Rs. ${data.amount}'),
                    BodySmallText(contentText: data.isPremium ? ' (Premium)' : ''),

                  ],
                ),
                const SizedBox(height: 4),
                BodyMediumText(
                  contentText: 'Date: ${ DateUtil.formatToDisplayDate(data.date)}',
                  textColor: Colors.black87,
                ),
                BodyMediumText(contentText: 'Day: ${data.day} '),
                BodyMediumText(contentText: 'Place: ${data.place}'),
                const SizedBox(height: 4),
                BodyMediumText(
                  contentText: data.isAnnounced ? 'Result Announced' : 'Upcoming',
                  textColor: data.isAnnounced ?  Colors.green : Colors.blue,
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                onPressed:
                    () =>
                {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.draw_resultRoute,
                  ),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
