import 'package:check_bond/data/models/bonds/data_model/analyzed_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/bond_type_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'analyze_res_model.g.dart';
@JsonSerializable()
class AnalyzeResModel extends BaseResponseModel{

  final int totalBonds;
  final int totalFirst;
  final int totalSecond;
  final int totalThird;
  final AnalyzedDataModel? data;
  AnalyzeResModel({required super.status, super.message, this.data,required this.totalBonds,required this.totalFirst,required this.totalSecond,required this.totalThird,});

  factory AnalyzeResModel.fromJson(Map<String, dynamic> json) => _$AnalyzeResModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyzeResModelToJson(this);
}

