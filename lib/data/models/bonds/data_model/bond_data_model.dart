import 'package:json_annotation/json_annotation.dart';

part 'bond_data_model.g.dart';

@JsonSerializable()
class BondDataModel {
  int id;
  int? drawId;
  String? boundNo;
  int? position;

  BondDataModel({
    required this.id,
    this.drawId,
    this.boundNo,
    this.position
  });

  /// Custom factory to support multiple casing styles
  factory BondDataModel.fromJson(Map<String, dynamic> json) {
    return BondDataModel(
      id: json['Id'] ?? json['id'] ?? 0,
      drawId: json['DrawId'] ?? json['drawId'] ?? 0,
      boundNo: json['BoundNo'] ?? json['boundNo'] ?? '',
      position: json['Position'] ?? json['position'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => _$BondDataModelToJson(this);
}
