import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:jalan2kuy/screens/ticket_beli_page.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'event_page.dart';
import 'profile_page.dart';
import 'ticket_beli_page.dart';

class EventDetailPage extends StatefulWidget {
  final String eventID;
  const EventDetailPage({Key? key, required this.eventID}) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPage();
}

class _EventDetailPage extends State<EventDetailPage> {
  Map<String, dynamic>? eventDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEventDetail();
  }

  Future<void> fetchEventDetail() async {
    setState(() => isLoading = true);

    try {
      String url = '${ApiConfig.eventDetail}?eventID=${widget.eventID}';

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
          eventDetail = responseData['data'];
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
    final String imagePath = eventDetail?['imagePath'] ?? '';
    final String imageUrl = '${ApiConfig.storageUrl}/$imagePath';

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      extendBody: true,

      body: Stack(
        children: [
          // ================= HEADER IMAGE =================
          SizedBox(
            height: 280,
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey.shade400),
            ),
          ),

          // Overlay
          Container(height: 280, color: Colors.black.withOpacity(0.35)),

          // ================= HEADER CONTENT =================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    eventDetail?['name']!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ================= DETAIL CARD =================
          Positioned(
            top: 240,
            left: 16,
            right: 16,
            bottom: 50, // ⬅️ ruang untuk bottom nav
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/bgfix2.jpg',
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      eventDetail?['location']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tanggal : '${eventDetail?['startDate']}' - '${eventDetail?['endDate']}'",
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Jam : '${eventDetail?['startTime']}' - '${eventDetail?['endTime']}'",
                    ),
                  ),

                  const SizedBox(height: 6),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Harga Tiket : ${eventDetail?['entranceFee']}",
                      style: const TextStyle(
                        color: Color(0xFF0B8B62),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        eventDetail?['description']!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(height: 1.6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketBeliPage(
                              eventID: eventDetail?['eventID'],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF17C3A5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Beli Tiket (${eventDetail?['entranceFee']})",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ================= BOTTOM NAVIGATION =================
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const EventPage()),
              (route) => false,
            );
          } else if (index == 3) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
