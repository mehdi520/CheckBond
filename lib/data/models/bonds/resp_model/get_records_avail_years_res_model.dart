import 'package:check_bond/data/models/bonds/data_model/record_avail_year_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_records_avail_years_res_model.g.dart';
@JsonSerializable()
class GetRecordsAvailYearsResModel extends BaseResponseModel{
  final List<RecordAvailYearDataModel>? data;
  GetRecordsAvailYearsResModel({required super.status, super.message, this.data});

  factory GetRecordsAvailYearsResModel.fromJson(Map<String, dynamic> json) => _$GetRecordsAvailYearsResModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetRecordsAvailYearsResModelToJson(this);
}

