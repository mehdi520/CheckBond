import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/won_bond_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_won_bounds_res_model.g.dart';
@JsonSerializable()
class GetWonBoundsResModel extends BaseResponseModel{
  final List<WonBondDataModel>? data;
  GetWonBoundsResModel({required super.status, super.message, this.data});

  factory GetWonBoundsResModel.fromJson(Map<String, dynamic> json) => _$GetWonBoundsResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetWonBoundsResModelToJson(this);
}
