// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataClass _$DataClassFromJson(Map<String, dynamic> json) => DataClass(
      trophies:
          (json['trophies'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$DataClassToJson(DataClass instance) => <String, dynamic>{
      'trophies': instance.trophies,
    };
