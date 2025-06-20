import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_details_data_model.dart';
import 'package:check_bond/infra/loader/overlay_service.dart';
import 'package:check_bond/infra/utils/enums.dart';
import 'package:check_bond/presentation/common_widgets/app_bars/basic_app_bar.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/body_medium_text.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/text_exports.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/title_medium_text.dart';
import 'package:check_bond/presentation/providers/providers/bond_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/configs/config_exports.dart';
import '../../../infra/utils/utils_exports.dart';

String normalize(String s) => s.replaceAll(RegExp(r'^0+'), '').trim();

class DrawResultScreen extends ConsumerStatefulWidget {
  final OverlayService _loadingService = OverlayService();
  final DrawDataModel data;

  DrawResultScreen({super.key, required this.data});

  @override
  ConsumerState<DrawResultScreen> createState() => _DrawResultScreenState();
}

class _DrawResultScreenState extends ConsumerState<DrawResultScreen> {
  String search = '';
  String? foundPrizeType;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bondProvider.notifier).getDrawResult(widget.data.drawId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiStatus = ref.watch(bondProvider);
    final drawResult = apiStatus.drawResult;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (apiStatus.apiStatus == ApiStatus.loading) {
        widget._loadingService.showLoadingOverlay(context);
      } else {
        widget._loadingService.hideLoadingOverlay();
      }
    });

    if (drawResult == null) {
      return const Scaffold(
        appBar: BasicAppBar(title: 'Draw Result'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: Text('No draw result available')),
        ),
      );
    }

    // Improved search: ignore leading zeros and spaces
    String? matchedPrizeType;
    if (search.isNotEmpty) {
      final normalizedSearch = normalize(search);
      for (final bond in drawResult.bonds ?? []) {
        if (normalize(bond.boundNo ?? '') == normalizedSearch) {
          matchedPrizeType =
              bond.position == 1
                  ? 'First Prize'
                  : (bond.position == 2 ? 'Second Prize' : 'Third Prize');
          break;
        }
      }
    }

    return Scaffold(
      appBar: BasicAppBar(title: 'Draw Result'),
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
                    BodyMediumText(
                      contentText: 'Draw #: ${drawResult.draw_no}',
                    ),
                    BodyMediumText(
                      contentText:
                          'Date: ${DateUtil.formatToDisplayDate(drawResult.draw_date)}',
                    ),
                    const SizedBox(height: 8),
                    BodyMediumText(
                      contentText:
                          'Total Bonds: ${drawResult.bonds?.length ?? 0}',
                      textColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Search Bar
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
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Search your bond number',
                      border: const OutlineInputBorder(),
                      suffixIcon:
                          search.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => setState(() => search = ''),
                              )
                              : null,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => setState(() => search = val.trim()),
                  ),
                  if (search.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child:
                          matchedPrizeType != null
                              ? Text(
                                'Congratulations! You won the $matchedPrizeType',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              : const Text(
                                'No prize found for this number.',
                                style: TextStyle(color: Colors.red),
                              ),
                    ),
                ],
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
                  if (drawResult.first_prize_worth != null)
                    _PrizeSection(
                      type: 'First Prize',
                      amount: 'Rs. ${drawResult.first_prize_worth}',
                      count:
                          drawResult.bonds
                              ?.where((b) => b.position == 1)
                              .length ??
                          0,
                      winners:
                          drawResult.bonds
                              ?.where((b) => b.position == 1)
                              .map((b) => b.boundNo ?? '')
                              .where((no) => no.isNotEmpty)
                              .toList() ??
                          [],
                      highlight: search,
                    ),
                  if (drawResult.second_prize_worth != null)
                    _PrizeSection(
                      type: 'Second Prize',
                      amount: 'Rs. ${drawResult.second_prize_worth}',
                      count:
                          drawResult.bonds
                              ?.where((b) => b.position == 2)
                              .length ??
                          0,
                      winners:
                          drawResult.bonds
                              ?.where((b) => b.position == 2)
                              .map((b) => b.boundNo ?? '')
                              .where((no) => no.isNotEmpty)
                              .toList() ??
                          [],
                      highlight: search,
                    ),
                  if (drawResult.third_prize_worth != null)
                    _PrizeSection(
                      type: 'Third Prize',
                      amount: 'Rs. ${drawResult.third_prize_worth}',
                      count:
                          drawResult.bonds
                              ?.where((b) => b.position == 3)
                              .length ??
                          0,
                      winners:
                          drawResult.bonds
                              ?.where((b) => b.position == 3)
                              .map((b) => b.boundNo ?? '')
                              .where((no) => no.isNotEmpty)
                              .toList() ??
                          [],
                      highlight: search,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Matched Bound
            _buildMatchedBondList(drawResult),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchedBondList(DrawDetailsDataModel? drawResult) {
    if (drawResult == null || drawResult.userWonBonds == null || drawResult.userWonBonds!.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.sentiment_dissatisfied,
                size: 48,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              TitleMediumText(
                contentText: 'Sorry! No bonds matched this time.',
                textStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleMediumText(
            contentText: 'Your Matched Bonds',
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: drawResult.userWonBonds!.map((bondNumber) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TitleMediumText(
                  contentText: bondNumber,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PrizeSection extends StatelessWidget {
  final String type;
  final String amount;
  final int count;
  final List<String> winners;
  final String highlight;

  const _PrizeSection({
    required this.type,
    required this.amount,
    required this.count,
    required this.winners,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: TitleSmallText(contentText: '$type ($amount)')),
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
            children:
                winners
                    .map((num) => _PrizeNumber(num: num, highlight: highlight))
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
  final String highlight;

  const _PrizeNumber({required this.num, required this.highlight});

  @override
  Widget build(BuildContext context) {
    final isMatch =
        highlight.isNotEmpty && normalize(num) == normalize(highlight);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isMatch ? Colors.yellow.shade700 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
        border: isMatch ? Border.all(color: Colors.red, width: 2) : null,
      ),
      child: BodyMediumText(
        contentText: num,
        textColor: isMatch ? Colors.black : Colors.black87,
      ),
    );
  }
}
