class order {
  final String orderID;
  final DateTime orderDate;
  final String userID;
  final double totalPrice;

  const order({
    required this.orderID,
    required this.orderDate,
    required this.userID,
    required this.totalPrice,
  });

  factory order.fromJson(Map<String, dynamic> json) {
    return order(
      orderID: json['orderID']?.toString() ?? '',
      orderDate: json['orderDate'] != null
          ? DateTime.tryParse(json['orderDate']) ?? DateTime.now()
          : DateTime.now(),
      userID: json['userID']?.toString() ?? '',
      totalPrice: (json['totalPrice'] is num)
          ? (json['totalPrice'] as num).toDouble()
          : double.tryParse(json['totalPrice']?.toString() ?? '0.0') ?? 0.0,
    );
  }
}
