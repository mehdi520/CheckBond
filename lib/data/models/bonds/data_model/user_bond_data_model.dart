import 'package:json_annotation/json_annotation.dart';

part 'user_bond_data_model.g.dart';

@JsonSerializable()
class UserBondDataModel {
  int bondId;
  String bondNumber;
  String? bondTypeName;
  int bondType;
  String createdAt;
  UserBondDataModel({
    required this.bondId,
    required this.bondNumber,
    required this.bondType,
    required this.createdAt,
     this.bondTypeName

  });

  factory UserBondDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserBondDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBondDataModelToJson(this);
}
