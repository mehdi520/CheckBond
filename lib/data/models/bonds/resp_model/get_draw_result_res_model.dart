import 'package:check_bond/data/models/bonds/data_model/bond_type_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_details_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_draw_result_res_model.g.dart';
@JsonSerializable()
class GetDrawResultResModel extends BaseResponseModel{
  final DrawDetailsDataModel? data;
  GetDrawResultResModel({required super.status, super.message, this.data});

  factory GetDrawResultResModel.fromJson(Map<String, dynamic> json) => _$GetDrawResultResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetDrawResultResModelToJson(this);
}

