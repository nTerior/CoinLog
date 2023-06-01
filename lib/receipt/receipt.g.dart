// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      merchant_name: json['merchant_name'] as String?,
      merchant_address: json['merchant_address'] as String?,
      merchant_phone: json['merchant_phone'] as String?,
      merchant_website: json['merchant_website'] as String?,
      merchant_tax_reg_no: json['merchant_tax_reg_no'] as String?,
      merchant_company_reg_no: json['merchant_company_reg_no'] as String?,
      merchant_logo: json['merchant_logo'] as String?,
      region: json['region'] as String?,
      mall: json['mall'] as String?,
      country: json['country'] as String?,
      receipt_no: json['receipt_no'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ReceiptItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      currency: json['currency'] as String?,
      total: (json['total'] as num?)?.toDouble(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      service_charge: json['service_charge'] as String?,
      tip: json['tip'] as String?,
      payment_method: json['payment_method'] as String?,
      payment_details: json['payment_details'] as String?,
      credit_card_type: json['credit_card_type'] as String?,
      credit_card_number: json['credit_card_number'] as String?,
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'merchant_name': instance.merchant_name,
      'merchant_address': instance.merchant_address,
      'merchant_phone': instance.merchant_phone,
      'merchant_website': instance.merchant_website,
      'merchant_tax_reg_no': instance.merchant_tax_reg_no,
      'merchant_company_reg_no': instance.merchant_company_reg_no,
      'merchant_logo': instance.merchant_logo,
      'region': instance.region,
      'mall': instance.mall,
      'country': instance.country,
      'receipt_no': instance.receipt_no,
      'date': instance.date,
      'time': instance.time,
      'items': instance.items,
      'currency': instance.currency,
      'total': instance.total,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'service_charge': instance.service_charge,
      'tip': instance.tip,
      'payment_method': instance.payment_method,
      'payment_details': instance.payment_details,
      'credit_card_type': instance.credit_card_type,
      'credit_card_number': instance.credit_card_number,
    };
