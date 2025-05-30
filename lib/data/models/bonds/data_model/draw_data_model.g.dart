// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrawDataModel _$DrawDataModelFromJson(Map<String, dynamic> json) =>
    DrawDataModel(
      drawId: (json['drawId'] as num).toInt(),
      bondTypeId: (json['bondTypeId'] as num).toInt(),
      isResultAnnounced: json['isResultAnnounced'] as bool,
      drawNo: (json['drawNo'] as num?)?.toInt(),
      bondType: json['bondType'] as String?,
      place: json['place'] as String?,
      day: json['day'] as String?,
      drawDate: json['drawDate'] as String?,
      firstPrizeWorth: json['firstPrizeWorth'] as String?,
      secondPrizeWorth: json['secondPrizeWorth'] as String?,
      thirdPrizeWorth: json['thirdPrizeWorth'] as String?,
    );

Map<String, dynamic> _$DrawDataModelToJson(DrawDataModel instance) =>
    <String, dynamic>{
      'drawId': instance.drawId,
      'bondTypeId': instance.bondTypeId,
      'drawNo': instance.drawNo,
      'bondType': instance.bondType,
      'place': instance.place,
      'day': instance.day,
      'drawDate': instance.drawDate,
      'isResultAnnounced': instance.isResultAnnounced,
      'firstPrizeWorth': instance.firstPrizeWorth,
      'secondPrizeWorth': instance.secondPrizeWorth,
      'thirdPrizeWorth': instance.thirdPrizeWorth,
    };
