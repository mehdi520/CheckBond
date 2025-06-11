// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'won_bond_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WonBondDataModel _$WonBondDataModelFromJson(Map<String, dynamic> json) =>
    WonBondDataModel(
      wonId: (json['wonId'] as num).toInt(),
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      position: (json['position'] as num).toInt(),
      bond: UserBondDataModel.fromJson(json['bond'] as Map<String, dynamic>),
      draw: DrawDataModel.fromJson(json['draw'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WonBondDataModelToJson(WonBondDataModel instance) =>
    <String, dynamic>{
      'wonId': instance.wonId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'position': instance.position,
      'bond': instance.bond,
      'draw': instance.draw,
    };
