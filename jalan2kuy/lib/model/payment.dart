class payment {
  final String paymentID;
  final DateTime paymentDate;
  final String paymentStatus;
  final String orderID;

  const payment({
    required this.paymentID,
    required this.paymentDate,
    required this.paymentStatus,
    required this.orderID,
  });

  factory payment.fromJson(Map<String, dynamic> json) {
    return payment(
      paymentID: json['paymentID']?.toString() ?? '',
      paymentDate: json['paymentDate'] != null
          ? DateTime.tryParse(json['paymentDate']) ?? DateTime.now()
          : DateTime.now(),
      paymentStatus: json['paymentStatus'] ?? '',
      orderID: json['orderID']?.toString() ?? '',
    );
  }
}
