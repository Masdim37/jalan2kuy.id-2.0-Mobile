import 'package:flutter/material.dart';
import 'login_page.dart'; // Pastikan import ini mengarah ke file login_page.dart kamu

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  // Warna hijau gelap khas jalan2kuy.id
  final Color primaryGreen = const Color(0xFF1E4E42); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Gambar Background Pemandangan
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgfix2.jpg', // Sesuaikan dengan nama file background kamu
              fit: BoxFit.cover,
            ),
          ),
          
          // 2. Konten Utama
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2), // Mendorong logo ke tengah
                
                // Lingkaran Logo Hijau
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    // Hanya menampilkan gambar logo.png tanpa teks tambahan
                    child: Image.asset(
                      'assets/images/logo.png', 
                      width: 160, // Ukuran diperbesar agar pas di tengah lingkaran
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                const Spacer(flex: 3), // Mendorong kotak putih ke bawah
                
                // Kotak Putih (Teks Sambutan)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Selamat datang di jalan2kuy.id',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Menggunakan font hitam
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Kami menyediakan informasi tentang wisata-\nwisata yang ada di Indonesia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Tombol "Get started"
                Container(
                  width: double.infinity,
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman LoginPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Get started',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32), // Jarak dari bawah layar
              ],
            ),
          ),
        ],
      ),
    );
  }
}