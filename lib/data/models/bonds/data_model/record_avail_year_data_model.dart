import 'package:json_annotation/json_annotation.dart';

part 'record_avail_year_data_model.g.dart';

@JsonSerializable()
class RecordAvailYearDataModel {
  int id;
  int year;
  RecordAvailYearDataModel({
    required this.id,
    required this.year,
  });

  factory RecordAvailYearDataModel.fromJson(Map<String, dynamic> json) => _$RecordAvailYearDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecordAvailYearDataModelToJson(this);
}
