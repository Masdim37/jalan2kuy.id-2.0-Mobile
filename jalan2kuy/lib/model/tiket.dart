class tiket {
  final String ticketID;
  final double price;
  final bool ticketStatus;
  final String eventID;
  final String orderID;

  const tiket({
    required this.ticketID,
    required this.price,
    required this.ticketStatus,
    required this.eventID,
    required this.orderID,
  });

  factory tiket.fromJson(Map<String, dynamic> json) {
    return tiket(
      ticketID: json['ticketID']?.toString() ?? '',
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      ticketStatus:
          json['ticketStatus'] == 1 ||
          json['ticketStatus'] == '1' ||
          json['ticketStatus'] == true,
      eventID: json['eventID']?.toString() ?? '',
      orderID: json['orderID']?.toString() ?? '',
    );
  }
}
