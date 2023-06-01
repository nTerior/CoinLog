// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptItem _$ReceiptItemFromJson(Map<String, dynamic> json) => ReceiptItem(
      amount: (json['amount'] as num?)?.toDouble(),
      description: json['description'] as String?,
      flags: json['flags'] as String?,
      qty: (json['qty'] as num?)?.toDouble(),
      remarks: json['remarks'] as String?,
      unitPrice: json['unitPrice'] as String?,
    );

Map<String, dynamic> _$ReceiptItemToJson(ReceiptItem instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'flags': instance.flags,
      'qty': instance.qty,
      'remarks': instance.remarks,
      'unitPrice': instance.unitPrice,
    };
