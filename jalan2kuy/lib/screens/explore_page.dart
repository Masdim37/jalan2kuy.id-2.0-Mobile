import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../widgets/bottom_nav_bar.dart';
import 'MyTicketPage.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'category_detail_page.dart';
import 'destination_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // Tampungan data dinamis dari API (Bisa berisi Kategori atau Destinasi)
  List<dynamic> apiData = [];
  bool isLoading = true;

  // 'category' untuk data kategori, 'search' untuk data hasil pencarian destinasi
  String dataType = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataDariApi(); // Pertama kali dibuka, ambil data kategori harian
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi Utama mengambil data dari Laravel (Bisa menerima keyword search)
  Future<void> fetchDataDariApi({String? keyword}) async {
    setState(() {
      isLoading = true;
    });

    // Menentukan URL, jika ada keyword tambah query parameter ?search=...
    String url = ApiConfig.destination;
    if (keyword != null && keyword.isNotEmpty) {
      url += '?search=$keyword';
    }

    // CCTV 1: Lihat URL apa yang sebenarnya sedang dipanggil oleh Flutter
    print("🌍 MENGHUBUNGI URL: $url");

    try {
      // 1. Ambil Token dari penyimpanan HP
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      // 2. Sertakan token di dalam Headers
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
          apiData = responseData['data'] ?? []; // Menyimpan array data
          dataType =
              responseData['type']; // Menyimpan tipe data ('category' / 'search')
          isLoading = false;
        });
      } else {
        print("❌ GAGAL! SERVER MERESPON: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("🚨 KONEKSI ERROR (MUNGKIN SALAH IP): $e");
      setState(() => isLoading = false);
      // print("Koneksi Error: $e");
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
                        'Destinasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // SEARCH BAR TEXTFIELD
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            // Jalankan fungsi search ke Laravel saat klik enter di keyboard
                            fetchDataDariApi(keyword: value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari destinasi yang ingin dituju...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      fetchDataDariApi(); // Bersihkan search, muat ulang kategori awal
                                    },
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // --- GRIDVIEW DINAMIS BERDASARKAN HASIL API ---
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF1B5E5E)),
                  )
                : apiData.isEmpty
                ? const Center(
                    child: Text(
                      'Destinasi tidak ditemukan',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.3,
                          ),
                      itemCount: apiData.length,
                      itemBuilder: (context, index) {
                        final item = apiData[index];
                        return _buildDynamicCard(item);
                      },
                    ),
                  ),
          ),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   currentIndex: 1,
      //   onTap: (index) {
      //     if (index == 0) {
      //       Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => const HomePage()),
      //         (route) => false,
      //       );
      //     } else if (index == 1) {
      //       Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => const MyTicketPage()),
      //         (route) => false,
      //       );
      //     } else if (index == 3) {
      //       Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => const profile_page.ProfilePage()),
      //         (route) => false,
      //       );
      //     }
      //   },
      // ),
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

  // --- LOGIKA PEMBUATAN CARD DINAMIS (BISA READ KATEGORI & DESTINASI) ---
  Widget _buildDynamicCard(dynamic item) {
    // 1. Siapkan variabel kosong
    String id = '';
    String title = '';
    String imagePath = '';

    // 2. Pisahkan logika pengambilan data berdasarkan 'type' dari Laravel
    if (dataType == 'category') {
      // AMBIL DATA KHUSUS KATEGORI
      id = item['destCategoryID']?.toString() ?? '';
      title = item['categoryName'] ?? '-';
      imagePath = item['categoryImage'] ?? '';
    } else {
      // AMBIL DATA KHUSUS DESTINASI (HASIL SEARCH)
      id = item['destinationID']?.toString() ?? '';
      title = item['name'] ?? '-';
      imagePath = item['thumbnailImagePath'] ?? item['imagePath'] ?? '';
    }

    // 3. Bentuk URL Gambar secara utuh
    final String imageUrl = '${ApiConfig.storageUrl}/$imagePath';

    return GestureDetector(
      onTap: () {
        // 4. Pisahkan navigasi halamannya
        if (dataType == 'category') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailPage(
                destCategoryID: id,
                categoryName: title,
                categoryImage: imageUrl,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DestinationDetailPage(
                destinationID: id,
                destinationName: title,
                destinationThumbnail: imageUrl,
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
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
            // Render Gambar dari URL Server
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            // Layer transparan gelap
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
            // Judul Teks (Bisa Nama Kategori atau Nama Destinasi)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title, // Langsung pakai variabel title yang sudah difilter di atas
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
