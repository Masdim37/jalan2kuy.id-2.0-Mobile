import 'dart:ui';
import 'package:flutter/material.dart';

// 1. Tambahkan import ini (sesuaikan path jika berbeda folder)
import 'login_form_page.dart'; 

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // Warna hijau gelap khas jalan2kuy.id
  final Color primaryGreen = const Color(0xFF1E5649);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Gambar Latar Belakang (Background)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // Ganti dengan path gambar pemandanganmu
                image: AssetImage('assets/images/bgfix2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Logo Tengah
          Align(
            alignment: const Alignment(0, -0.4),
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: primaryGreen,
                shape: BoxShape.circle,
              ),
              child: const Center(
                // Ganti dengan path logo putih jalan2kuy.id
                // child: Image.asset('assets/images/logo_white.png', width: 150),
                child: Text(
                  'jalan2kuy.id',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // 3. Efek Blur / Frosted Glass pada Background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),

          // 4. Container Putih (Modal Bottom Sheet)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55, // Mengambil ~55% layar
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5), // Warna putih keabu-abuan terang
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Tombol Close (X) di kanan atas
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey, size: 24),
                        onPressed: () {
                          // Aksi untuk kembali atau tutup
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  
                  // Judul
                  const Text(
                    'Login or sign up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Menggunakan font hitam
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Tombol Login
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          // 2. Aksi navigasi ke LoginFormPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginFormPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen, // Hijau jalan2kuy.id
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Teks "Buat Akun?" di paling bawah
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: TextButton(
                      onPressed: () {
                        // Aksi navigasi ke daftar (Register)
                      },
                      child: const Text(
                        'Buat Akun?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
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
    );
  }
}