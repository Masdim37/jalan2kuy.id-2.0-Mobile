import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'success_page.dart';

class TicketBeliPage extends StatefulWidget {
  final String eventID;
  const TicketBeliPage({Key? key, required this.eventID}) : super(key: key);

  @override
  State<TicketBeliPage> createState() => _TicketBeliPage();
}

class _TicketBeliPage extends State<TicketBeliPage> {
  Map<String, dynamic>? eventBeliDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEventBeliDetail();
  }

  Future<void> fetchEventBeliDetail() async {
    setState(() => isLoading = true);

    try {
      String url = '${ApiConfig.eventBeliTiket}?eventID=${widget.eventID}';

      print("🌍 MENGHUBUNGI URL: $url");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Connection': 'keep-alive',
        },
      );

      // CCTV 2: Lihat status balasan dari Laravel
      print("🚀 STATUS CODE: ${response.statusCode}");
      // CCTV 3: Lihat isi JSON yang ditangkap Flutter
      print("📦 ISI RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // CCTV 4: Pastikan status success-nya true
        print("✅ SUCCESS STATUS: ${responseData['success']}");

        setState(() {
          eventBeliDetail = responseData['data'];
          isLoading = false;
        });
      } else {
        print("❌ GAGAL! SERVER MERESPON: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("🚨 KONEKSI ERROR (MUNGKIN SALAH IP): $e");
      print("Error fetching detail: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text("Konfirmasi Pembelian"),
        backgroundColor: const Color(0xFF17C3A5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detail Pesanan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventBeliDetail?['name'] ?? 'Nama Event',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tanggal"),
                      Text(eventBeliDetail?['startDate'] ?? '-'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Pembayaran"),
                      Text(
                        eventBeliDetail?['entranceFee'] ?? '',
                        style: const TextStyle(
                          color: Color(0xFF0B8B62),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF17C3A5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Konfirmasi Beli",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
