// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bond_summary_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBondSummaryDataModel _$UserBondSummaryDataModelFromJson(
        Map<String, dynamic> json) =>
    UserBondSummaryDataModel(
      totalBond: (json['totalBond'] as num).toInt(),
      totalWorth: (json['totalWorth'] as num).toInt(),
      bonds: (json['bonds'] as List<dynamic>)
          .map((e) => BondCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserBondSummaryDataModelToJson(
        UserBondSummaryDataModel instance) =>
    <String, dynamic>{
      'totalWorth': instance.totalWorth,
      'totalBond': instance.totalBond,
      'bonds': instance.bonds,
    };

BondCountModel _$BondCountModelFromJson(Map<String, dynamic> json) =>
    BondCountModel(
      bondCount: (json['bondCount'] as num).toInt(),
      bondWorth: (json['bondWorth'] as num).toInt(),
      bondType: json['bondType'] as String,
    );

Map<String, dynamic> _$BondCountModelToJson(BondCountModel instance) =>
    <String, dynamic>{
      'bondWorth': instance.bondWorth,
      'bondCount': instance.bondCount,
      'bondType': instance.bondType,
    };
