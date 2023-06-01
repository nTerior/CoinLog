import 'package:coin_log/receipt/receipt_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt.g.dart';

@JsonSerializable()
class Receipt {
  String? merchant_name;
  final String? merchant_address;
  final String? merchant_phone;
  final String? merchant_website;
  final String? merchant_tax_reg_no;
  final String? merchant_company_reg_no;
  final String? merchant_logo;

  final String? region;
  final String? mall;
  final String? country;
  final String? receipt_no;

  final String? date;
  final String? time;

  final List<ReceiptItem>? items;

  final String? currency;
  final double? total;
  final double? subtotal;
  final double? tax;

  final String? service_charge;
  final String? tip;

  final String? payment_method;
  final String? payment_details;

  final String? credit_card_type;
  final String? credit_card_number;

  Receipt({
    required this.merchant_name,
    required this.merchant_address,
    required this.merchant_phone,
    required this.merchant_website,
    required this.merchant_tax_reg_no,
    required this.merchant_company_reg_no,
    required this.merchant_logo,
    required this.region,
    required this.mall,
    required this.country,
    required this.receipt_no,
    required this.date,
    required this.time,
    required this.items,
    required this.currency,
    required this.total,
    required this.subtotal,
    required this.tax,
    required this.service_charge,
    required this.tip,
    required this.payment_method,
    required this.payment_details,
    required this.credit_card_type,
    required this.credit_card_number,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
