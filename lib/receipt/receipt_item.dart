import 'package:json_annotation/json_annotation.dart';

part 'receipt_item.g.dart';

@JsonSerializable()
class ReceiptItem {
  final double? amount;
  final String? description;
  final String? flags;
  final double? qty;
  final String? remarks;
  final String? unitPrice;

  ReceiptItem({
    required this.amount,
    required this.description,
    required this.flags,
    required this.qty,
    required this.remarks,
    required this.unitPrice,
  });

  factory ReceiptItem.fromJson(Map<String, dynamic> json) =>
      _$ReceiptItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptItemToJson(this);
}
