import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import '../widgets/bottom_nav_bar.dart';
import 'explore_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Warna Cyan/Mint khas tulisan jalan2kuy.id di desain
  final Color accentCyan = const Color(0xFF00CFA5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. Bagian Atas (Background, Header, Text, Search) ---
            Stack(
              children: [
                // Gambar Background Utama
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgfix2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Gradien gelap agar teks putih di atas gambar mudah dibaca
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.5),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                
                // Konten di Atas Gambar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Logo
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                        
                        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                        
                        // Hero Text
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.3,
                            ),
                            children: [
                              const TextSpan(text: 'Temukan\nPetualanganmu\nBersama '),
                              TextSpan(
                                text: 'jalan2kuy.id',
                                style: TextStyle(color: accentCyan),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Sub-hero Text
                        const Text(
                          'Kami menawarkan berbagai\ninformasi tentang wisata, event\ndan gambar wisata untuk anda',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Search Bar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Cari destinasi yang ingin dituju..',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search, color: Colors.black, size: 28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // --- 2. Bagian Bawah (Menu Kategori Kartu Putih) ---
            Transform.translate(
              offset: const Offset(0, -20), 
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // DESTINASI - KLIK UNTUK KE EXPLORE PAGE
                    _buildCategoryItem(
                      BootstrapIcons.globe_americas, 
                      'Destinasi', 
                      Colors.blue,
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const ExplorePage()),
                          (route) => false,
                        );
                      },
                    ),
                    // TIKET - Belum ada halaman
                    _buildCategoryItem(
                      BootstrapIcons.ticket_perforated, 
                      'Tiket', 
                      Colors.orange,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Halaman Tiket segera hadir!')),
                        );
                      },
                    ),
                    // EVENT - Belum ada halaman
                    _buildCategoryItem(
                      BootstrapIcons.calendar_event, 
                      'Event', 
                      Colors.redAccent,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Halaman Event segera hadir!')),
                        );
                      },
                    ),
                    // GALERI - Belum ada halaman
                    _buildCategoryItem(
                      BootstrapIcons.images, 
                      'Galeri', 
                      Colors.blueAccent,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Halaman Galeri segera hadir!')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 80), 
          ],
        ),
      ),

      // --- 3. Bottom Navigation Bar (TERPISAH) ---
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0, // Home aktif (index 0)
        onTap: (index) {
          if (index == 0) return; // Sudah di Home
          
          if (index == 1) {
            // Navigate ke Explore
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ExplorePage()),
              (route) => false,
            );
          } else if (index == 2) {
            // Ticket page belum ada
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Halaman Ticket segera hadir!')),
            );
          } else if (index == 3) {
            // Navigate ke Profile (pakai push agar bisa kembali dengan tombol back)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }

  // --- Widget Bantuan untuk Ikon Kategori (dengan onTap) ---
  Widget _buildCategoryItem(
    IconData icon, 
    String label, 
    Color iconColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Icon(icon, size: 28, color: iconColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}