// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw_details_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrawDetailsDataModel _$DrawDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    DrawDetailsDataModel(
      draw_id: (json['draw_id'] as num).toInt(),
      draw_date: json['draw_date'] as String,
      draw_no: (json['draw_no'] as num?)?.toInt(),
      first_prize_worth: json['first_prize_worth'] as String?,
      second_prize_worth: json['second_prize_worth'] as String?,
      third_prize_worth: json['third_prize_worth'] as String?,
      bonds: (json['bonds'] as List<dynamic>?)
          ?.map((e) => BondDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DrawDetailsDataModelToJson(
        DrawDetailsDataModel instance) =>
    <String, dynamic>{
      'draw_id': instance.draw_id,
      'draw_date': instance.draw_date,
      'draw_no': instance.draw_no,
      'first_prize_worth': instance.first_prize_worth,
      'second_prize_worth': instance.second_prize_worth,
      'third_prize_worth': instance.third_prize_worth,
      'bonds': instance.bonds,
    };
