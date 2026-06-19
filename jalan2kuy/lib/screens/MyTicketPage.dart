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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ⚠️ PENTING: Jika saat Login Anda menyimpannya dengan nama 'token', ubah 'auth_token' ini menjadi 'token'
    String? token = prefs.getString('auth_token');

    if (token != null) {
      try {
        final response = await http.get(
          // ⚠️ PENTING: Sesuaikan huruf besar/kecil dengan yang ada di file api_config.dart Anda
          Uri.parse(ApiConfig.MyTicket),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true', // Jika pakai ngrok
          },
        );

        // Untuk mengecek secara langsung di Tab Debug Console VS Code
        debugPrint('STATUS CODE MY TICKET: ${response.statusCode}');
        debugPrint('BODY MY TICKET: ${response.body}');

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            // Ambil array data, berikan fallback [] jika null
            myTickets = data['data'] ?? [];
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
          debugPrint('Gagal ambil data API tiket!');
        }
      } catch (e) {
        setState(() => isLoading = false);
        debugPrint('Error koneksi di MyTicket: $e');
      }
    } else {
      // Masuk ke sini jika token tidak ditemukan di penyimpanan HP
      debugPrint('TOKEN KOSONG! API tidak dipanggil.');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⬇️ WillPopScope BERFUNGSI UNTUK MENGUBAH FUNGSI TOMBOL BACK FISIK HP ⬇️
    return WillPopScope(
      onWillPop: () async {
        // Arahkan paksa ke HomePage dan buang sisa tumpukan halaman
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) => const HomePage(),
            transitionDuration: Duration.zero,
          ),
        );
        return false; // Mencegah pop default Android (yang lari ke Login)
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1B5E5E),
          title: const Text(
            'My Tickets',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading:
              false, // Hilangkan tombol back default AppBar
          elevation: 0,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF1B5E5E)),
              )
            : myTickets.isEmpty
            ? const Center(
                child: Text(
                  'Belum ada tiket yang dibeli.',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: myTickets.length,
                itemBuilder: (context, index) {
                  final tiket = myTickets[index];
                  final event = tiket['event'] ?? {};
                  final order = tiket['order'] ?? {};

                  final String eventName =
                      event['nameEvent'] ?? 'Event Tidak Diketahui';
                  final String imagePath =
                      event['fotoEvent'] ?? event['image'] ?? '';
                  // Pastikan URL Ngrok ini adalah yang aktif hari ini
                  final String imageUrl =
                      'https://dimmer-starring-clapping.ngrok-free.dev/assets/$imagePath';
                  final String price = order['total_price']?.toString() ?? '0';
                  final String qty = order['qty']?.toString() ?? '1';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 85,
                              height: 85,
                              color: Colors.grey[300],
                              child: imagePath.isNotEmpty
                                  ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.image,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                    )
                                  : const Icon(
                                      Icons.image,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        eventName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'x $qty',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Rp. $price',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 32,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Buka tiket...'),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF1B5E5E,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        'Lihat Tiket',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
      ),
    );
  }
}
