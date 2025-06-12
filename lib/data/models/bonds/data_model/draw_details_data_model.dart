import 'package:check_bond/data/models/bonds/data_model/bond_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'draw_details_data_model.g.dart';

@JsonSerializable()
class DrawDetailsDataModel {
  int draw_id;
  String draw_date;
  int? draw_no;
  String? first_prize_worth;
  String? second_prize_worth;
  String? third_prize_worth;
  List<BondDataModel>? bonds;
  List<String>? userWonBonds;

  DrawDetailsDataModel({
    required this.draw_id,
    required this.draw_date,
    this.draw_no,
    this.first_prize_worth,
    this.second_prize_worth,
    this.third_prize_worth,
    this.bonds,
    this.userWonBonds
  });

  factory DrawDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$DrawDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrawDetailsDataModelToJson(this);
}
