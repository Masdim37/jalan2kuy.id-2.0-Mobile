import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PrintTicketPage extends StatelessWidget {
  final dynamic tiket;
  
  const PrintTicketPage({Key? key, required this.tiket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Parsing Data Event
    final event = tiket['event'] ?? {};
    final eventName = event['name'] ?? 'Nama Event';
    final location = event['location'] ?? '-';
    final date = "${event['startDate'] ?? '-'} s/d ${event['endDate'] ?? '-'}";
    final String tiketID = tiket['tiketID']?.toString() ?? '-';
    
    // Harga
    final rawPrice = tiket['price']?.toString() ?? '0';
    final priceDisplay = rawPrice.contains('.') ? rawPrice.split('.')[0] : rawPrice;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("E-Ticket Anda"),
        backgroundColor: const Color(0xFF16c4b0),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // BAGIAN ATAS KARTU
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ID TIKET:", style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFF2ecc71).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                            child: const Text("LUNAS", style: TextStyle(color: Color(0xFF2ecc71), fontSize: 12, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      Text(tiketID, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                      const SizedBox(height: 20),
                      Text(eventName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, size: 20, color: Color(0xFF16c4b0)),
                          const SizedBox(width: 8),
                          Expanded(child: Text(date, style: const TextStyle(fontSize: 14))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, size: 20, color: Color(0xFF16c4b0)),
                          const SizedBox(width: 8),
                          Expanded(child: Text(location, style: const TextStyle(fontSize: 14))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text("Total: Rp $priceDisplay", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF16c4b0))),
                    ],
                  ),
                ),
                
                // GARIS PUTUS-PUTUS
                Row(
                  children: [
                    Container(height: 20, width: 10, decoration: const BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.horizontal(right: Radius.circular(20)))),
                    Expanded(child: CustomPaint(painter: HorizontalDashedLinePainter())),
                    Container(height: 20, width: 10, decoration: const BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.horizontal(left: Radius.circular(20)))),
                  ],
                ),

                // BAGIAN BAWAH KARTU (QR CODE)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      const Text("Tunjukkan QR ini ke Petugas", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 15),
                      QrImageView(
                        data: tiketID,
                        version: QrVersions.auto,
                        size: 180.0,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 15),
                      const Text("Jalan2Kuy.id", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black38)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 8, dashSpace = 5, startX = 0;
    final paint = Paint()..color = Colors.grey.shade400..strokeWidth = 2;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}