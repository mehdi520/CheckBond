import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:check_bond/data/models/user/data_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_profile_res_model.g.dart';
@JsonSerializable()
class GetProfileResModel extends BaseResponseModel{
  final UserModel? data;
  GetProfileResModel({required super.status, super.message, this.data});

  factory GetProfileResModel.fromJson(Map<String, dynamic> json) => _$GetProfileResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetProfileResModelToJson(this);
}