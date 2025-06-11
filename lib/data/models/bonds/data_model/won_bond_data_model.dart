import 'package:check_bond/data/models/bonds/data_model/bond_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'won_bond_data_model.g.dart';

@JsonSerializable()
class WonBondDataModel {
  int wonId;
  String? status;
  String? createdAt;
  int position;
  UserBondDataModel bond;
  DrawDataModel draw;

  WonBondDataModel({
    required this.wonId,
    this.status,
    this.createdAt,
   required this.position,
    required this.bond,
    required this.draw
  });

  factory WonBondDataModel.fromJson(Map<String, dynamic> json) =>
      _$WonBondDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$WonBondDataModelToJson(this);

}