import 'package:json_annotation/json_annotation.dart';

part 'draw_data_model.g.dart';

@JsonSerializable()
class DrawDataModel {
  int drawId;
  int bondTypeId;
  int? drawNo;
  String? bondType;
  String? place;
  String? day;
  String? drawDate;
  bool isResultAnnounced;
  String? firstPrizeWorth;
  String? secondPrizeWorth;
  String? thirdPrizeWorth;

  DrawDataModel({
    required this.drawId,
    required this.bondTypeId,
    required this.isResultAnnounced,
     this.drawNo,
     this.bondType,
     this.place,
     this.day,
     this.drawDate,
    this.firstPrizeWorth,
    this.secondPrizeWorth,
    this.thirdPrizeWorth,
  });

  factory DrawDataModel.fromJson(Map<String, dynamic> json) =>
      _$DrawDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrawDataModelToJson(this);
}
