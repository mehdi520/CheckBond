import 'package:json_annotation/json_annotation.dart';

part 'sch_bond_data_model.g.dart';

@JsonSerializable()
class SchBondDataModel {
  int id;
  int yearId;
  String amount;
  bool isPremium;
  String day;
  String date;
  String place;
  bool isAnnounced;

  SchBondDataModel({
    required this.id,
    required this.yearId,
    required this.amount,
    required this.isAnnounced,
    required this.isPremium,
    required this.date,
    required this.day,
    required this.place,
  });

  factory SchBondDataModel.fromJson(Map<String, dynamic> json) => _$SchBondDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$SchBondDataModelToJson(this);
}
