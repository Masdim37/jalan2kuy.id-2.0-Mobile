import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'edit_akun_page.dart';
import 'welcome_page.dart';
import '../config/api_config.dart';
import 'login_page.dart';
import 'MyTicketPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// Placeholder MyTicketPage since original class was not found.
// class MyTicketPage extends StatelessWidget {
//   const MyTicketPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Tickets'),
//         backgroundColor: const Color(0xFF1B5E5E),
//       ),
//       body: const Center(child: Text('My Tickets Page')),
//     );
//   }
// }

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Panggil fungsi API saat halaman pertama kali dibuka
  }

  Future<void> _logout(BuildContext context) async {
    // Tampilkan loading indicator jika perlu (opsional)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // 1. Ambil token dari penyimpanan lokal
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(
      'token',
    ); // Sesuaikan key ini dengan yang Anda buat saat Login

    if (token != null) {
      try {
        // 2. Beri tahu server untuk menghapus token (Revoke)
        await http.post(
          Uri.parse(ApiConfig.logout),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      } catch (e) {
        // Abaikan error koneksi saat logout, yang penting token di HP dihapus
        debugPrint('Error saat menghubungi server untuk logout: $e');
      }
    }

    // 3. Hapus token dan data user dari penyimpanan lokal HP
    await prefs.remove('token');
    // Jika Anda menyimpan data lain seperti nama/email, hapus juga:
    // await prefs.remove('user_data');

    // Tutup loading indicator
    if (mounted) Navigator.pop(context);

    // 4. Arahkan kembali ke halaman Login dan hapus tumpukan riwayat halaman (clear stack)
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ), // Sesuaikan nama Class Login
        (route) => false,
      );
    }
  }

  Future<void> fetchUserData() async {
    // Ambil token dari memori HP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      // Jika tidak ada token, arahkan kembali ke login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return;
    }

    final String url = ApiConfig.account;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // Kirim token sebagai kunci masuk
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userData = data['data']; // Simpan data user ke variabel
          isLoading = false; // Matikan animasi loading
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengambil data profil')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak bisa terhubung ke server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header Hijau Tua
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 30,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E5E), // Hijau tua
            ),
            child: Column(
              children: [
                // Logo di kiri atas + Tombol Back
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
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 30),
                // Icon Profile Besar
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Color(0xFF1B5E5E),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Konten Form (Menampilkan Loading atau Form)
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF1B5E5E)),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        // Pastikan 'nameUser', 'username', dll sesuai dengan nama kolom di tabel database Anda
                        _buildProfileField(
                          'Name',
                          userData?['nameUser'] ?? '-',
                        ),
                        const SizedBox(height: 12),
                        _buildProfileField(
                          'Username',
                          userData?['username'] ?? '-',
                        ),
                        const SizedBox(height: 12),
                        _buildProfileField('Email', userData?['email'] ?? '-'),
                        const SizedBox(height: 12),
                        _buildProfileField(
                          'Nomor Telepon',
                          userData?['phone'] ?? '-',
                        ),
                        const SizedBox(height: 12),
                        _buildProfileField(
                          'Jenis Kelamin',
                          userData?['gender'] == true ||
                                  userData?['gender'] == 1
                              ? 'Laki-laki'
                              : (userData?['gender'] == false ||
                                        userData?['gender'] == 0
                                    ? 'Perempuan'
                                    : '-'),
                        ),
                        const SizedBox(height: 12),
                        _buildProfileField(
                          'Tanggal Lahir',
                          userData?['birthDate'] != null
                              ? userData!['birthDate'].toString().substring(
                                  0,
                                  10,
                                ) // Mengambil 'YYYY-MM-DD'
                              : '-',
                        ),
                        const SizedBox(height: 12),
                        _buildProfileField(
                          'Password',
                          '********',
                        ), // Password sebaiknya tetap disensor
                        const SizedBox(height: 25),

                        // Tombol Edit Profile
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditAccountPage(),
                                ),
                              );
                              if (result == true) {
                                setState(() {
                                  isLoading = true; // Munculkan loading lagi
                                });
                                fetchUserData(); // Panggil ulang API untuk ambil data terbaru
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E8B8B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Tombol Logout
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _showLogoutDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E8B8B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Tombol Delete Account
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _showDeleteAccountDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E8B8B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Delete Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        // UBAH ANGKA INI SESUAI HALAMAN SAAT INI (0 untuk Home, 1 Explore, 2 Ticket, 3 Profile)
        currentIndex: 3,
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

  // Widget Form Field sudah dimodifikasi untuk menampilkan Label dan Value
  Widget _buildProfileField(String label, String value) {
    return Container(
      width: double.infinity,
      // Hapus batasan height mutlak (height: 50) diganti dengan minHeight agar fleksibel
      constraints: const BoxConstraints(minHeight: 50),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Bagian Label (Diberi porsi ruang 2 bagian)
          Expanded(
            flex: 12,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // 2. Bagian Pembatas (Garis Vertikal / Teks '|')
          Container(
            height: 20, // Tinggi garis pembatas
            width: 1.5, // Ketebalan garis
            color: Colors.black26, // Warna garis
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ), // Jarak kiri-kanan garis
          ),

          // 3. Bagian Data (Diberi porsi ruang 3 bagian agar lebih luas)
          Expanded(
            flex: 28,
            child: Text(
              value,
              textAlign: TextAlign
                  .left, // Anda bisa ubah jadi TextAlign.right jika ingin rata kanan
              overflow:
                  TextOverflow.ellipsis, // PENTING: Mencegah overflow pixel
              maxLines: 1, // Membatasi teks hanya 1 baris
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- LOGIC LOGOUT ---
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        // Gunakan dialogContext agar tidak bentrok
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Apakah anda yakin untuk Logout Akun?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      // onPressed: () async {
                      //   // Hapus Token dari memori HP
                      //   SharedPreferences prefs =
                      //       await SharedPreferences.getInstance();
                      //   await prefs.remove('token');
                      //   await prefs.remove('user_name');

                      //   if (context.mounted) {
                      //     Navigator.pushAndRemoveUntil(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const LoginPage(),
                      //       ),
                      //       (route) => false,
                      //     );
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(content: Text('Berhasil logout')),
                      //     );
                      //   }
                      // },
                      onPressed: () {
                        // 1. Tutup dialog konfirmasi terlebih dahulu
                        Navigator.pop(dialogContext);

                        // 2. Panggil fungsi _logout utama yang akan memunculkan
                        // loading, tembak API, hapus data, dan pindah halaman
                        _logout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC5E618),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text(
                        'NO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Apakah anda yakin untuk Delete Akun?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // 1. SIMPAN Navigator & ScaffoldMessenger SEBELUM proses await dimulai.
                        // Ini akan mencegah error "context tidak valid / unmounted"
                        final navigator = Navigator.of(context);
                        final scaffoldMessenger = ScaffoldMessenger.of(context);

                        // 2. Tutup popup dialog konfirmasi "Apakah anda yakin..."
                        Navigator.pop(dialogContext);

                        // 3. Tampilkan Loading Indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (loadingContext) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        // 4. Ambil Token (Pastikan key-nya benar, misal 'auth_token' atau 'token')
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? token = prefs.getString(
                          'token',
                        ); // sesuaikan key

                        // 5. Panggil API Hapus Akun ke Server
                        if (token != null) {
                          try {
                            await http.post(
                              Uri.parse(ApiConfig.deleteAccount),
                              headers: {
                                'Accept': 'application/json',
                                'Authorization': 'Bearer $token',
                              },
                            );
                          } catch (e) {
                            debugPrint('Error delete account API: $e');
                          }
                        }

                        // 6. Hapus token lokal di memori HP
                        await prefs.remove('token'); // sesuaikan key

                        // 7. Tutup Loading Indicator menggunakan navigator yang sudah disimpan
                        navigator.pop();

                        // 8. Tampilkan pesan berhasil (WAJIB SEBELUM PINDAH HALAMAN)
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Akun berhasil dihapus'),
                            backgroundColor:
                                Colors.grey, // Opsional: Beri warna hijau
                          ),
                        );

                        // 9. Arahkan pengguna ke WelcomePage / LoginPage
                        navigator.pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                const WelcomePage(), // Sesuaikan halaman tujuan
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC5E618),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      // Menutup dialog pembatalan
                      onPressed: () => Navigator.pop(dialogContext),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text(
                        'NO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
