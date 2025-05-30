import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/presentation/common_widgets/app_bars/basic_app_bar.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/body_medium_text.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/text_exports.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'mock_draw_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String normalize(String s) => s.replaceAll(RegExp(r'^0+'), '').trim();

class DrawResultScreen extends ConsumerStatefulWidget {
  final DrawDataModel data;

  const DrawResultScreen({super.key, required this.data});

  @override
  ConsumerState<DrawResultScreen> createState() => _DrawResultScreenState();
}

class _DrawResultScreenState extends ConsumerState<DrawResultScreen> {
  String search = '';
  String? foundPrizeType;

  @override
  Widget build(BuildContext context) {
    final drawResult = ref.watch(mockDrawResultProvider);
    final info = drawResult.drawInfo;
    final prizes = drawResult.prizes;

    // Improved search: ignore leading zeros and spaces
    String? matchedPrizeType;
    if (search.isNotEmpty) {
      final normalizedSearch = normalize(search);
      for (final prize in prizes) {
        for (final winner in prize.winners) {
          if (normalize(winner) == normalizedSearch) {
            matchedPrizeType = prize.type;
            break;
          }
        }
        if (matchedPrizeType != null) break;
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
                    TitleSmallText(contentText: '${info.denomination} - ${info.title}'),
                    const SizedBox(height: 4),
                    BodyMediumText(contentText: 'Draw #: ${info.drawNumber}'),
                    BodyMediumText(contentText: 'Date: ${info.date}'),
                    BodyMediumText(contentText: 'Place: ${info.place}'),
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
                      border: OutlineInputBorder(),
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
                  ...prizes.map(
                    (prize) => _PrizeSection(prize: prize, highlight: search),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Matched Bound
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
              child: Builder(
                builder: (context) {
                  // Dummy user bonds
                  final userBonds = ['268813', '009914', '123456', '959990', '000001'];
                  List<Map<String, String?>> matchedBonds = userBonds.map((bond) {
                    String? position;
                    for (final prize in prizes) {
                      for (final winner in prize.winners) {
                        if (normalize(winner) == normalize(bond)) {
                          position = prize.type;
                          break;
                        }
                      }
                      if (position != null) break;
                    }
                    return {
                      'bond': bond,
                      'position': position,
                    };
                  }).where((e) => e['position'] != null).toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleMediumText(contentText: 'Your Saved Bonds'),
                      const SizedBox(height: 8),
                      if (matchedBonds.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Sorry, Unfortunately your bonds didn't win in this draw. Wish you best of luck for next draw",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        ...matchedBonds.map((e) => Row(
                          children: [
                            BodyMediumText(contentText: e['bond']!, textColor: Colors.black87),
                            const SizedBox(width: 12),
                            BodyMediumText(
                              contentText: e['position']!,
                              textColor: e['position'] == 'First Prize'
                                  ? Colors.orange
                                  : (e['position'] == 'Second Prize'
                                      ? Colors.blue
                                      : Colors.green),
                            ),
                          ],
                        )),
                    ],
                  );
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
  final Prize prize;
  final String highlight;

  const _PrizeSection({required this.prize, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleSmallText(contentText: '${prize.type} (${prize.amount})'),
            const SizedBox(height: 8),
            if (prize.winners.length <= 10)
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: prize.winners
                      .map((num) => _PrizeNumber(num: num, highlight: highlight))
                      .toList(),
                ),
              )
            else
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: prize.winners
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
      child: BodyMediumText(contentText: num,textColor: isMatch ? Colors.black : Colors.black87,)

    );
  }
}
