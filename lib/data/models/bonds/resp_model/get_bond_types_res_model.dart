import 'package:check_bond/data/models/bonds/data_model/bond_type_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_bond_types_res_model.g.dart';
@JsonSerializable()
class GetBondTypesResModel extends BaseResponseModel{
  final List<BondTypeDataModel>? data;
  GetBondTypesResModel({required super.status, super.message, this.data});

  factory GetBondTypesResModel.fromJson(Map<String, dynamic> json) => _$GetBondTypesResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetBondTypesResModelToJson(this);
}

