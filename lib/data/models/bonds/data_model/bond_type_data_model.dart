import 'package:json_annotation/json_annotation.dart';

part 'bond_type_data_model.g.dart';

@JsonSerializable()
class BondTypeDataModel {
  int typeId;
  String bondType;
  bool isPermium;
  BondTypeDataModel({
    required this.typeId,
    required this.bondType,
  required this.isPermium,

  });

  factory BondTypeDataModel.fromJson(Map<String, dynamic> json) => _$BondTypeDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$BondTypeDataModelToJson(this);
}
