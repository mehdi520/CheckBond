// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_won_bounds_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWonBoundsResModel _$GetWonBoundsResModelFromJson(
        Map<String, dynamic> json) =>
    GetWonBoundsResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WonBondDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetWonBoundsResModelToJson(
        GetWonBoundsResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
