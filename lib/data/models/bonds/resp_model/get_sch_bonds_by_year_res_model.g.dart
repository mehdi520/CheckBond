// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sch_bonds_by_year_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSchBondsByYearResModel _$GetSchBondsByYearResModelFromJson(
        Map<String, dynamic> json) =>
    GetSchBondsByYearResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SchBondDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSchBondsByYearResModelToJson(
        GetSchBondsByYearResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
