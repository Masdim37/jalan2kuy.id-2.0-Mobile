import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
// import 'explore_page.dart';
import '../widgets/bottom_nav_bar.dart';
import 'explore_page.dart';
import 'home_page.dart';
import 'event_page.dart';
import 'profile_page.dart';
import 'MyTicketPage.dart';

class GaleriPage extends StatefulWidget {
  const GaleriPage({super.key});

  @override
  State<GaleriPage> createState() => _GaleriPage();
}

class _GaleriPage extends State<GaleriPage> {
  List<dynamic> destinations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Panggil fungsi API saat halaman pertama kali dibuka
    fetchGaleri();
  }

  Future<void> fetchGaleri() async {
    setState(() => isLoading = true);

    try {
      String url = ApiConfig.gallery;
      print("🌍 MENGHUBUNGI URL: $url");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

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
    // final List<Map<String, String>> galleryItems = [
    //   {
    //     'title': 'Danau Weekuri',
    //     'image': 'assets/images/weekuri.jpg',
    //   },
    //   {
    //     'title': 'Gunung Rinjani',
    //     'image': 'assets/images/rinjani.jpg',
    //   },
    //   {
    //     'title': 'Candi Prambanan',
    //     'image': 'assets/images/prambanan.jpg',
    //   },
    //   {
    //     'title': 'Monumen Nasional\n(Monas)',
    //     'image': 'assets/images/monas.jpg',
    //   },
    // ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      body: Column(
        children: [
          // HEADER
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bgfix2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(height: 250, color: Colors.black.withOpacity(0.25)),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Mengarahkan ke HomePage dan menghapus semua history halaman sebelumnya
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                                (route) =>
                                    false, // Menghapus seluruh stack halaman lama
                              );
                            },
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
                      const Text(
                        'Galleri',
                        style: TextStyle(
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

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(18),
              child: GridView.builder(
                itemCount: destinations.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final item = destinations[index];
                  String rawImagePath =
                      item['imagePath'] ?? item['image'] ?? '';
                  final String imageUrl =
                      '${ApiConfig.storageUrl}/$rawImagePath';

                  return Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image, size: 50),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        item['name']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),

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
}
