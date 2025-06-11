import 'package:check_bond/data/models/bonds/data_model/draw_details_data_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/analyze_res_model.dart';
import 'package:check_bond/infra/loader/overlay_service.dart';
import 'package:check_bond/infra/utils/enums.dart';
import 'package:check_bond/presentation/common_widgets/app_bars/basic_app_bar.dart';
import 'package:check_bond/presentation/common_widgets/buttons/PrimaryButton.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/body_medium_text.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/text_exports.dart';
import 'package:check_bond/presentation/providers/providers/bond_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/utils/utils_exports.dart';

class AnaylzeDrawResultScreen extends ConsumerStatefulWidget {
  final OverlayService _loadingService = OverlayService();

  final AnalyzeResModel result;
  final DrawDetailsDataModel data;
  AnaylzeDrawResultScreen({super.key, required this.result, required this.data});

  @override
  ConsumerState<AnaylzeDrawResultScreen> createState() => _AnaylzeDrawResultScreenState();
}

class _AnaylzeDrawResultScreenState extends ConsumerState<AnaylzeDrawResultScreen> {
  List<Map<String, dynamic>> _getPrizes() {
    final prizes = <Map<String, dynamic>>[];
    
    // First Prize
    if (widget.data.first_prize_worth != null) {
      prizes.add({
        'type': 'First Prize',
        'amount': 'Rs. ${widget.data.first_prize_worth}',
        'count': widget.result.totalFirst,
        'winners': widget.data.bonds
            ?.where((bond) => bond.position == 1)
            .map((bond) => bond.boundNo ?? '')
            .where((no) => no.isNotEmpty)
            .toList() ?? [],
      });
    }

    // Second Prize
    if (widget.data.second_prize_worth != null) {
      prizes.add({
        'type': 'Second Prize',
        'amount': 'Rs. ${widget.data.second_prize_worth}',
        'count': widget.result.totalSecond,
        'winners': widget.data.bonds
            ?.where((bond) => bond.position == 2)
            .map((bond) => bond.boundNo ?? '')
            .where((no) => no.isNotEmpty)
            .toList() ?? [],
      });
    }

    // Third Prize
    if (widget.data.third_prize_worth != null) {
      prizes.add({
        'type': 'Third Prize',
        'amount': 'Rs. ${widget.data.third_prize_worth}',
        'count': widget.result.totalThird,
        'winners': widget.data.bonds
            ?.where((bond) => bond.position == 3)
            .map((bond) => bond.boundNo ?? '')
            .where((no) => no.isNotEmpty)
            .toList() ?? [],
      });
    }

    return prizes;
  }

  @override
  Widget build(BuildContext context) {
    final apiStatus = ref.watch(bondProvider);
    print(apiStatus.apiStatus.toString());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (apiStatus.apiStatus == ApiStatus.loading) {
       widget._loadingService.showLoadingOverlay(context);
      } else {
        widget._loadingService.hideLoadingOverlay();
      }

      if(apiStatus.apiIdentifier == "importDrawResult") {
        if (apiStatus.apiStatus == ApiStatus.success) {
          ToastUtils.showSuccess(apiStatus.resp?.message ?? "Success");
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (apiStatus.apiStatus == ApiStatus.error) {
          ToastUtils.showError(apiStatus.resp?.message ?? "Sorry");
        }
      }
    });

    final prizes = _getPrizes();

    return Scaffold(
      appBar: BasicAppBar(title: 'Analyze Draw Result'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Draw Info
            Container(
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleSmallText(contentText: 'Draw Information'),
                    const SizedBox(height: 8),
                    BodyMediumText(contentText: 'Draw #: ${widget.data.draw_no}'),
                    BodyMediumText(contentText: 'Date: ${widget.data.draw_date}'),
                    const SizedBox(height: 8),
                    BodyMediumText(
                      contentText: 'Total Bonds: ${widget.result.totalBonds}',
                      textColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Prizes
            Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...prizes.map(
                    (prize) => _PrizeSection(
                      type: prize['type'] as String,
                      amount: prize['amount'] as String,
                      count: prize['count'] as int,
                      winners: prize['winners'] as List<String>,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: 'Submit',
                onTap: () {
                  ref.read(bondProvider.notifier).importDrawResult(widget.result.data!.id!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrizeSection extends StatelessWidget {
  final String type;
  final String amount;
  final int count;
  final List<String> winners;

  const _PrizeSection({
    required this.type,
    required this.amount,
    required this.count,
    required this.winners,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TitleSmallText(contentText: '$type ($amount)'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: BodyMediumText(
                contentText: 'Count: $count',
                textColor: Colors.blue.shade900,

              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: winners
                .map((num) => _PrizeNumber(num: num))
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _PrizeNumber extends StatelessWidget {
  final String num;

  const _PrizeNumber({required this.num});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: BodyMediumText(
        contentText: num,
        textColor: Colors.black87,
      ),
    );
  }
}
