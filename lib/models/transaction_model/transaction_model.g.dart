// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      amount: json['amount'] as int,
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'id': instance.id,
    };
