// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_draw_result_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDrawResultResModel _$GetDrawResultResModelFromJson(
        Map<String, dynamic> json) =>
    GetDrawResultResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DrawDetailsDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDrawResultResModelToJson(
        GetDrawResultResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
