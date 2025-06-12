import 'package:check_bond/data/models/bonds/data_model/user_bond_summary_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_user_bond_summary_res_model.g.dart';
@JsonSerializable()
class GetUserBondSummaryResModel extends BaseResponseModel{
  final UserBondSummaryDataModel? data;
  GetUserBondSummaryResModel({required super.status, super.message, this.data});

  factory GetUserBondSummaryResModel.fromJson(Map<String, dynamic> json) => _$GetUserBondSummaryResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserBondSummaryResModelToJson(this);
}

