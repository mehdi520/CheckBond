// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bond_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBondDataModel _$UserBondDataModelFromJson(Map<String, dynamic> json) =>
    UserBondDataModel(
      bondId: (json['bondId'] as num).toInt(),
      bondNumber: json['bondNumber'] as String,
      bondType: (json['bondType'] as num).toInt(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$UserBondDataModelToJson(UserBondDataModel instance) =>
    <String, dynamic>{
      'bondId': instance.bondId,
      'bondNumber': instance.bondNumber,
      'bondType': instance.bondType,
      'createdAt': instance.createdAt,
    };
