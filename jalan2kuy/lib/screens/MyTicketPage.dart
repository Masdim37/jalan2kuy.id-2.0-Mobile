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
    // Gunakan key token yang sesuai (misal 'auth_token' atau 'token')
    String? token = prefs.getString('auth_token');

    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse(ApiConfig.MyTicket),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true', // Jika pakai ngrok
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            myTickets = data['data']; // Ambil list tiket dari response JSON
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
          debugPrint('Gagal ambil data: ${response.body}');
        }
      } catch (e) {
        setState(() => isLoading = false);
        debugPrint('Error koneksi: $e');
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background abu-abu muda seperti halaman lain
      backgroundColor: const Color(0xFFF5F5F5),

      // Header hijau tua seperti halaman lain
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E5E),
        title: const Text(
          'My Tickets',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading:
            false, // Hilangkan tombol back karena ini halaman utama nav bar
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

                // Ambil data dari JSON (Sesuaikan key ini dengan field di database Anda)
                final String eventName =
                    event['nameEvent'] ?? 'Event Tidak Diketahui';

                // Untuk mendapatkan gambar event
                final String imagePath =
                    event['fotoEvent'] ?? event['image'] ?? '';
                // Contoh path gambar, sesuaikan dengan logic URL gambar Anda
                final String imageUrl =
                    'https://dimmer-starring-clapping.ngrok-free.dev/assets/$imagePath';

                final String price = order['total_price']?.toString() ?? '0';
                final String qty =
                    order['qty']?.toString() ??
                    '1'; // Default ke 1 jika tidak ada qty di tabel tiket

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
                        // 1. Gambar Event di sebelah kiri
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
                                // Placeholder jika gambar tidak ada
                                : const Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // 2. Informasi Tiket di sebelah kanan
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Baris Nama Event & Qty
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
                                      maxLines: 2, // Maksimal 2 baris
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

                              // Tulisan "Total"
                              const Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),

                              // Harga Tiket (Warna Orange)
                              Text(
                                'Rp. $price',
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Tombol Lihat Tiket di kanan bawah
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 32,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // TODO: Navigasi ke halaman detail / scan QR Tiket
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
                                      ), // Warna hijau tua
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
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

      // Navigasi Bawah
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2, // Index 2 adalah untuk MyTickets
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ExplorePage()),
            );
          } else if (index == 2) {
            return; // Sudah di halaman My Tickets
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }
}
