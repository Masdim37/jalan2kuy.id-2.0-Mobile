import 'package:flutter/material.dart';
// Import package bootstrap icons yang sudah diinstal
import 'package:bootstrap_icons/bootstrap_icons.dart'; 

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
      backgroundColor: const Color(0xFFF5F5F5), // Latar abu-abu sangat muda agar kartu putih terlihat
      
      // extendBody digunakan agar background bisa menyapu sampai ke bawah bottom nav bar
      extendBody: true, 
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. Bagian Atas (Background, Header, Text, Search) ---
            Stack(
              children: [
                // Gambar Background Utama
                Container(
                  height: MediaQuery.of(context).size.height * 0.55, // Tinggi sekitar 55% dari layar
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgfix2.jpg'), // Pastikan file gambar ini ada
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
                          children: const [
                            // Menggunakan Bootstrap Icon untuk kompas/explore
                            Icon(BootstrapIcons.compass, color: Colors.white, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'jalan2kuy.id',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: MediaQuery.of(context).size.height * 0.08), // Jarak proporsional
                        
                        // Hero Text (RichText untuk warna berbeda)
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
                                style: TextStyle(color: accentCyan), // Teks warna cyan
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
                            decoration: InputDecoration(
                              hintText: 'Cari destinasi yang ingin dituju..',
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                              border: InputBorder.none,
                              // Icon pencarian bawaan Flutter
                              prefixIcon: const Icon(Icons.search, color: Colors.black, size: 28),
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
            // Kita angkat sedikit ke atas agar menumpuk rapat dengan gambar background
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
                    // MENGGUNAKAN BOOTSTRAP ICONS DI SINI
                    _buildCategoryItem(BootstrapIcons.globe_americas, 'Destinasi', Colors.blue),
                    _buildCategoryItem(BootstrapIcons.ticket_perforated, 'Tiket', Colors.orange),
                    _buildCategoryItem(BootstrapIcons.calendar_event, 'Event', Colors.redAccent),
                    _buildCategoryItem(BootstrapIcons.images, 'Galeri', Colors.blueAccent),
                  ],
                ),
              ),
            ),
            
            // Jarak tambahan ke bawah agar bisa di-scroll sebelum menyentuh bottom nav
            const SizedBox(height: 80), 
          ],
        ),
      ),

      // --- 3. Bottom Navigation Bar Bergaya Floating ---
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24), // Membuatnya mengambang
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.confirmation_num_outlined, 'Ticket', false),
            _buildNavItem(Icons.home, 'Home', true), // Home diset Aktif (true)
            _buildNavItem(Icons.search, 'Explore', false),
            _buildNavItem(Icons.person_outline, 'Profile', false),
          ],
        ),
      ),
    );
  }

  // --- Widget Bantuan untuk Ikon Kategori ---
  Widget _buildCategoryItem(IconData icon, String label, Color iconColor) {
    return Column(
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
            // Ikon akan di-render di sini (baik bawaan Flutter maupun Bootstrap Icons)
            child: Icon(icon, size: 28, color: iconColor),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Menggunakan font warna hitam
          ),
        ),
      ],
    );
  }

  // --- Widget Bantuan untuk Bottom Navigation Item ---
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 32,
          // Ikon yang aktif akan berwarna Cyan, yang tidak akan berwarna Hitam
          color: isActive ? accentCyan : Colors.black87,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isActive ? accentCyan : Colors.black87, // Teks yang tidak aktif berwarna hitam
          ),
        ),
      ],
    );
  }
}