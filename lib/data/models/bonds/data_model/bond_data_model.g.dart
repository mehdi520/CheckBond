// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bond_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BondDataModel _$BondDataModelFromJson(Map<String, dynamic> json) =>
    BondDataModel(
      id: (json['id'] as num).toInt(),
      drawId: (json['drawId'] as num?)?.toInt(),
      boundNo: json['boundNo'] as String?,
      position: (json['position'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BondDataModelToJson(BondDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'drawId': instance.drawId,
      'boundNo': instance.boundNo,
      'position': instance.position,
    };
