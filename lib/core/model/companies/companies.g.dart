// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Companies _$CompaniesFromJson(Map<String, dynamic> json) => Companies(
      productName: json['productName'] as String,
      money: json['money'] as int,
      imageUrl: json['imageUrl'] as String,
    )..key = json['key'] as String?;

Map<String, dynamic> _$CompaniesToJson(Companies instance) => <String, dynamic>{
      'productName': instance.productName,
      'money': instance.money,
      'imageUrl': instance.imageUrl,
      'key': instance.key,
    };
