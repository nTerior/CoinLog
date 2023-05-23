class ReceiptItem {
  final String name;
  final double cost;

  const ReceiptItem({required this.name, required this.cost});
}

class Receipt {
  final List<ReceiptItem> items;
  final double total;

  const Receipt({required this.items, required this.total});
}
