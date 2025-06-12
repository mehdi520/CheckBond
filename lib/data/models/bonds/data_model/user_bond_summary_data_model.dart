import 'package:json_annotation/json_annotation.dart';

part 'user_bond_summary_data_model.g.dart';

@JsonSerializable()
class UserBondSummaryDataModel {
  int totalWorth;
  int totalBond;
  List<BondCountModel> bonds;

  UserBondSummaryDataModel({
    required this.totalBond,
    required this.totalWorth,
    required this.bonds

  });

  factory UserBondSummaryDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserBondSummaryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBondSummaryDataModelToJson(this);
}

@JsonSerializable()
class BondCountModel {
  int bondWorth;
  int bondCount;
  String bondType;

  BondCountModel({
    required this.bondCount,
    required this.bondWorth,
    required this.bondType,

  });

  factory BondCountModel.fromJson(Map<String, dynamic> json) =>
      _$BondCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$BondCountModelToJson(this);
}

