// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_bond_summary_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserBondSummaryResModel _$GetUserBondSummaryResModelFromJson(
        Map<String, dynamic> json) =>
    GetUserBondSummaryResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UserBondSummaryDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserBondSummaryResModelToJson(
        GetUserBondSummaryResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
