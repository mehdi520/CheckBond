import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_draws_by_type_res_model.g.dart';
@JsonSerializable()
class GetDrawsByTypeResModel extends BaseResponseModel{
  final List<DrawDataModel>? data;
  GetDrawsByTypeResModel({required super.status, super.message, this.data});

  factory GetDrawsByTypeResModel.fromJson(Map<String, dynamic> json) => _$GetDrawsByTypeResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetDrawsByTypeResModelToJson(this);
}

