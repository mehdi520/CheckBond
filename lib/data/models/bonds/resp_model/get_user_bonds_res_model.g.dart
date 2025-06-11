// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_bonds_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserBondsResModel _$GetUserBondsResModelFromJson(
        Map<String, dynamic> json) =>
    GetUserBondsResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserBondDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserBondsResModelToJson(
        GetUserBondsResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
