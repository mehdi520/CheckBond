import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawInfo {
  final String denomination;
  final String title;
  final int drawNumber;
  final String date;
  final String place;

  DrawInfo({
    required this.denomination,
    required this.title,
    required this.drawNumber,
    required this.date,
    required this.place,
  });
}

class Prize {
  final String type;
  final String amount;
  final List<String> winners;

  Prize({
    required this.type,
    required this.amount,
    required this.winners,
  });
}

class DrawResult {
  final DrawInfo drawInfo;
  final List<Prize> prizes;

  DrawResult({required this.drawInfo, required this.prizes});
}

final mockDrawResultProvider = Provider<DrawResult>((ref) {
  return DrawResult(
    drawInfo: DrawInfo(
      denomination: 'Rs. 100/-',
      title: 'Student Welfare Prize Bonds',
      drawNumber: 50,
      date: '2022-11-15',
      place: 'Karachi',
    ),
    prizes: [
      Prize(
        type: 'First Prize',
        amount: 'Rs. 700,000/-',
        winners: ['268813'],
      ),
      Prize(
        type: 'Second Prize',
        amount: 'Rs. 200,000/- each',
        winners: ['009914', '298412', '886501'],
      ),
      Prize(
        type: 'Third Prize',
        amount: 'Rs. 1,000/- each',
        winners: [
          '001282', '038951', '086294', '125164', '167097', '206809', '250674', '286233', '334805', '384088', '421593', '460585',
          '001287', '039582', '087014', '125230', '167386', '207398', '250949', '287149', '334987', '385280', '423262', '462360',
          // ... (add all other numbers as needed)
          '959990'
        ],
      ),
    ],
  );
}); 