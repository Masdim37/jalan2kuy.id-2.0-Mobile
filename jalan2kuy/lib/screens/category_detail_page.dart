import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Jika pakai token
import '../config/api_config.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'profile_page.dart';
import 'destination_detail_page.dart';

// UBAH MENJADI STATEFUL WIDGET AGAR BISA MEMANGGIL API
class CategoryDetailPage extends StatefulWidget {
  final String destCategoryID;
  final String categoryName;
  final String categoryImage;

  const CategoryDetailPage({
    Key? key,
    required this.destCategoryID,
    required this.categoryName,
    required this.categoryImage,
  }) : super(key: key);

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<dynamic> destinations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Panggil fungsi API saat halaman pertama kali dibuka
    fetchDestinations();
  }

  Future<void> fetchDestinations() async {
    setState(() => isLoading = true);

    try {
      // 1. Siapkan URL dengan menambahkan query parameter category_id
      // Contoh: http://192.168.1.40:8000/api/destination/by-category?destCategoryID=ctg001
      String url =
          '${ApiConfig.destinationByCategory}?destCategoryID=${widget.destCategoryID}';

      print("🌍 MENGHUBUNGI URL: $url");

      // 2. Ambil token jika API Anda dikunci (Hapus bagian ini jika API public)
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      // 3. Panggil API
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // Sertakan token
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
          destinations = responseData['data'] ?? [];
          isLoading = false;
        });
      } else {
        print("❌ GAGAL! SERVER MERESPON: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("🚨 KONEKSI ERROR (MUNGKIN SALAH IP): $e");
      print("Error fetching category destinations: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header dengan Background Gambar Kategori
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                // PERBAIKAN: Gunakan Image.network karena gambar dikirim berupa URL utuh dari ExplorePage
                child: Image.network(
                  widget.categoryImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey),
                ),
              ),
              Container(
                height: 250,
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
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tombol Back & Logo
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 12),
                          Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Judul Kategori (Diambil dari widget.)
                      Text(
                        widget.categoryName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // List Destinasi
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF1B5E5E)),
                  )
                : destinations.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada destinasi di kategori ini',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final destination = destinations[index];
                      return _buildDestinationCard(context, destination);
                    },
                  ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        // UBAH ANGKA INI SESUAI HALAMAN SAAT INI (0 untuk Home, 1 Explore, 2 Ticket, 3 Profile)
        currentIndex: 1,
        onTap: (index) {
          // 0: HOME
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const HomePage(),
                transitionDuration: Duration
                    .zero, // Hilangkan animasi transisi agar seperti ganti tab
              ),
            );
          }
          // 1: EXPLORE
          else if (index == 1) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const ExplorePage(),
                transitionDuration: Duration.zero,
              ),
            );
          }
          // 2: TICKET
          else if (index == 2) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const MyTicketPage(),
                transitionDuration: Duration.zero,
              ),
            );
          }
          // 3: PROFILE
          else if (index == 3) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                // Catatan: Jika di explore_page Anda meng-alias profile_page, ganti const ProfilePage() menjadi const profile_page.ProfilePage()
                pageBuilder: (context, animation1, animation2) =>
                    const ProfilePage(),
                transitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
    );
  }

  // Card Destinasi - GAMBAR + NAMA DARI API
  Widget _buildDestinationCard(BuildContext context, dynamic destination) {
    // Membentuk URL gambar secara dinamis (menggunakan string interpolation yang bersih)
    String imagePath =
        destination['thumbnailImagePath'] ?? destination['imagePath'] ?? '';
    final String imageUrl = '${ApiConfig.storageUrl}/$imagePath';

    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail destinasi
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailPage(
              destinationID: destination['destinationID']?.toString() ?? '',
              destinationName: destination['name'] ?? '-',
              destinationThumbnail: imageUrl,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gambar Destinasi (Network)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade400, Colors.grey.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.broken_image,
                      size: 60,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            // Overlay Gelap
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Nama Destinasi di Tengah
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  destination['name'] ?? '-',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
