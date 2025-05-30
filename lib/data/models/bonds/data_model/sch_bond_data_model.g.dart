// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sch_bond_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchBondDataModel _$SchBondDataModelFromJson(Map<String, dynamic> json) =>
    SchBondDataModel(
      id: (json['id'] as num).toInt(),
      yearId: (json['yearId'] as num).toInt(),
      amount: json['amount'] as String,
      isAnnounced: json['isAnnounced'] as bool,
      isPremium: json['isPremium'] as bool,
      date: json['date'] as String,
      day: json['day'] as String,
      place: json['place'] as String,
    );

Map<String, dynamic> _$SchBondDataModelToJson(SchBondDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'yearId': instance.yearId,
      'amount': instance.amount,
      'isPremium': instance.isPremium,
      'day': instance.day,
      'date': instance.date,
      'place': instance.place,
      'isAnnounced': instance.isAnnounced,
    };
