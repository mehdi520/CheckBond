import 'package:json_annotation/json_annotation.dart';


part 'analyzed_data_model.g.dart';

@JsonSerializable()
class AnalyzedDataModel {
  int id;
  String? json;

  AnalyzedDataModel({
    required this.id,
     this.json
  });

  factory AnalyzedDataModel.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyzedDataModelToJson(this);

}