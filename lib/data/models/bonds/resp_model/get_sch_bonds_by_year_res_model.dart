import 'package:check_bond/data/models/bonds/data_model/sch_bond_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_sch_bonds_by_year_res_model.g.dart';
@JsonSerializable()
class GetSchBondsByYearResModel extends BaseResponseModel{
  final List<SchBondDataModel>? data;
  GetSchBondsByYearResModel({required super.status, super.message, this.data});

  factory GetSchBondsByYearResModel.fromJson(Map<String, dynamic> json) => _$GetSchBondsByYearResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetSchBondsByYearResModelToJson(this);
}

