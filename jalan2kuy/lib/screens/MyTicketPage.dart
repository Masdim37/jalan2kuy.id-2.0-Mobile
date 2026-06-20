import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'profile_page.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({Key? key}) : super(key: key);

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  List<dynamic> myTickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMyTickets();
  }

  Future<void> _fetchMyTickets() async {
    setState(() => isLoading = true);

    try {
      // 1. Siapkan URL
      String url = '${ApiConfig.MyTicket}';

      print("🌍 MENGHUBUNGI URL: $url");

      // 2. Ambil token jika API Anda dikunci (Hapus bagian ini jika API public)
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(ApiConfig.MyTicket),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Connection': 'keep-alive',
        },
      );

      print("🚀 STATUS CODE: ${response.statusCode}");
      // CCTV 3: Lihat isi JSON yang ditangkap Flutter
      print("📦 ISI RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // CCTV 4: Pastikan status success-nya true
        print("✅ SUCCESS STATUS: ${responseData['success']}");
        setState(() {
          // Ambil array data, berikan fallback [] jika null
          myTickets = responseData['data'] ?? [];
          isLoading = false;
        });
      } else {
        print("❌ GAGAL! SERVER MERESPON: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("🚨 KONEKSI ERROR $e");
      print("Error fetching myTicket Data $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // --- HEADER FIX BACKGROUND & SEARCH BAR ---
          Stack(
            children: [
              Container(
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bgfix2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'My Ticket',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF1B5E5E)),
                  )
                : myTickets.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada tiket yang anda beli',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: myTickets.length,
                    itemBuilder: (context, index) {
                      final tiket = myTickets[index];
                      return _buildTicketCard(context, tiket);
                    },
                  ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => const HomePage(),
                transitionDuration: Duration.zero,
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => const ExplorePage(),
                transitionDuration: Duration.zero,
              ),
            );
          } else if (index == 2) {
            // Sudah di halaman tiket
            return;
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => const ProfilePage(),
                transitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context, dynamic tiket) {
    // 1. Ambil data nested object 'event' secara aman
    final event = tiket['event'] ?? {};

    // 2. Parsing status tiket secara aman
    int status = -1;
    if (tiket['tiketStatus'] != null) {
      status = int.tryParse(tiket['tiketStatus'].toString()) ?? -1;
    }

    // HELPER 2: Memformat jam secara aman (contoh: "17:00:00" jadi "17:00")
    String formatTimeSafe(String? timeStr) {
      if (timeStr == null || timeStr.isEmpty) return '00:00';
      if (timeStr.length >= 5 && timeStr.contains(':')) {
        return timeStr.substring(0, 5);
      }
      return timeStr;
    }

    // Ekstraksi data dengan benar
    String eventName = event['name'] ?? '-';
    String location = event['location'] ?? '-';

    // Konversi tanggal UTC ke WIB
    String startDate = event['startDate'] ?? '-';
    String endDate = event['endDate'] ?? '-';

    // MENGAMBIL WAKTU DARI KEY YANG TEPAT
    // Catatan: Jika di API kamu namanya bukan startTime/endTime (misal: entranceTime),
    // silakan ubah kata 'startTime' di bawah ini sesuai nama key di JSON-mu.
    String startTime = formatTimeSafe(event['startTime']?.toString());
    String endTime = formatTimeSafe(event['endTime']?.toString());

    // Format tampilan harga (menghilangkan .00 di belakang jika ada)
    String rawPrice = tiket['price']?.toString() ?? '0';
    String displayPrice = rawPrice.contains('.')
        ? rawPrice.split('.')[0]
        : rawPrice;

    // Helper Widget untuk merender bagian kanan (Status & Tombol)
    Widget buildStatusArea() {
      if (status == 1) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF2ecc71),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    "Sudah Dibayar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tiket Siap Digunakan",
              style: TextStyle(
                color: Color(0xFF27ae60),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                print('Print tiket ID: ${tiket['tiketID']}');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3498db),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x333498db),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.print, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text(
                      "Print Tiket",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else if (status == 0) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFf1c40f),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, color: Color(0xFF333333), size: 14),
                  SizedBox(width: 6),
                  Text(
                    "Pending",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Menunggu Transfer",
              style: TextStyle(
                color: Color(0xFFb7950b),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print('Bayar order ID: ${tiket['orderID']}');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16c4b0),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3316c4b0),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.payments, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text(
                          "Bayar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    print('Batal order ID: ${tiket['orderID']}');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFe74c3c),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text(
                          "Batal",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFe74c3c),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cancel, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    "Dibatalkan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Transaksi Hangus",
              style: TextStyle(
                color: Color(0xFFc0392b),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFF1abc9c), width: 5),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // BAGIAN KIRI: INFORMASI TIKET
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID TIKET: ${tiket['tiketID'] ?? '-'}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          eventName,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Tanggal (Sekarang sudah format YYYY-MM-DD HH:mm:ss lokal)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF1abc9c),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "$startDate s/d $endDate",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Waktu (Sekarang mengambil dari startTime & endTime)
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Color(0xFF1abc9c),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "$startTime - $endTime WIB",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Lokasi
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFF1abc9c),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                location,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Harga
                        Text(
                          "Harga: Rp $displayPrice",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // GARIS PUTUS-PUTUS PEMISAH TENGAH
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomPaint(
                    size: const Size(1.5, double.infinity),
                    painter: DashedLinePainter(),
                  ),
                ),

                // BAGIAN KANAN: STATUS DAN TOMBOL ACTION
                Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
                  child: buildStatusArea(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5;
    double dashSpace = 3;
    double startY = 0;
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1.5;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
