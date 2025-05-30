// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_draws_by_type_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDrawsByTypeResModel _$GetDrawsByTypeResModelFromJson(
        Map<String, dynamic> json) =>
    GetDrawsByTypeResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DrawDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDrawsByTypeResModelToJson(
        GetDrawsByTypeResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
