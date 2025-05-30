// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_records_avail_years_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRecordsAvailYearsResModel _$GetRecordsAvailYearsResModelFromJson(
        Map<String, dynamic> json) =>
    GetRecordsAvailYearsResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              RecordAvailYearDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetRecordsAvailYearsResModelToJson(
        GetRecordsAvailYearsResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
