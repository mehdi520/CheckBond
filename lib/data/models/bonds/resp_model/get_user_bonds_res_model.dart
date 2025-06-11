import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_user_bonds_res_model.g.dart';
@JsonSerializable()
class GetUserBondsResModel extends BaseResponseModel{
  final List<UserBondDataModel>? data;
  GetUserBondsResModel({required super.status, super.message, this.data});

  factory GetUserBondsResModel.fromJson(Map<String, dynamic> json) => _$GetUserBondsResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserBondsResModelToJson(this);
}

