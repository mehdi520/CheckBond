// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyzeResModel _$AnalyzeResModelFromJson(Map<String, dynamic> json) =>
    AnalyzeResModel(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AnalyzedDataModel.fromJson(json['data'] as Map<String, dynamic>),
      totalBonds: (json['totalBonds'] as num).toInt(),
      totalFirst: (json['totalFirst'] as num).toInt(),
      totalSecond: (json['totalSecond'] as num).toInt(),
      totalThird: (json['totalThird'] as num).toInt(),
    );

Map<String, dynamic> _$AnalyzeResModelToJson(AnalyzeResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'totalBonds': instance.totalBonds,
      'totalFirst': instance.totalFirst,
      'totalSecond': instance.totalSecond,
      'totalThird': instance.totalThird,
      'data': instance.data,
    };
