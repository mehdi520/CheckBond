// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bond_type_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BondTypeDataModel _$BondTypeDataModelFromJson(Map<String, dynamic> json) =>
    BondTypeDataModel(
      typeId: (json['typeId'] as num).toInt(),
      bondType: json['bondType'] as String,
      isPermium: json['isPermium'] as bool,
    );

Map<String, dynamic> _$BondTypeDataModelToJson(BondTypeDataModel instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'bondType': instance.bondType,
      'isPermium': instance.isPermium,
    };
