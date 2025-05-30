// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bond_types_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBondTypesResModel _$GetBondTypesResModelFromJson(
        Map<String, dynamic> json) =>
    GetBondTypesResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BondTypeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBondTypesResModelToJson(
        GetBondTypesResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
