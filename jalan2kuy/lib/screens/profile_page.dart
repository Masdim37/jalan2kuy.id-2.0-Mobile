// import 'package:flutter/material.dart';
// import '../widgets/bottom_nav_bar.dart';
// import 'home_page.dart';
// import 'explore_page.dart';
// import 'edit_akun_page.dart';
// import 'login_page.dart';
// import 'welcome_page.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: Column(
//         children: [
//           // Header Hijau Tua
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.only(top: 50, bottom: 30, left: 20, right: 20),
//             decoration: const BoxDecoration(
//               color: Color(0xFF1B5E5E), // Hijau tua
//             ),
//             child: Column(
//               children: [
//                 // Logo di kiri atas + Tombol Back
//                 Row(
//                   children: [
//                     // Tombol kembali ke HomePage
//                     IconButton(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                     ),
//                     const SizedBox(width: 12),
//                     Image.asset(
//                       'assets/images/logo.png',
//                       width: 100,
//                       height: 100,
//                     ),
//                     const SizedBox(width: 8),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//                 // Icon Profile Besar
//                 Container(
//                   width: 80,
//                   height: 80,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.person,
//                     size: 50,
//                     color: Color(0xFF1B5E5E),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Profile',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Konten Form
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//               child: Column(
//                 children: [
//                   // Form Fields
//                   _buildProfileField('Name'),
//                   const SizedBox(height: 12),
//                   _buildProfileField('Username'),
//                   const SizedBox(height: 12),
//                   _buildProfileField('Email'),
//                   const SizedBox(height: 12),
//                   _buildProfileField('Nomor Telepon'),
//                   const SizedBox(height: 12),
//                   _buildProfileField('Jenis Kelamin'),
//                   const SizedBox(height: 12),
//                   _buildProfileField('Tanggal Lahir'),
//                   const SizedBox(height: 12),
//                   _buildProfileField('Password'),
//                   const SizedBox(height: 25),

//                   // Tombol Edit Profile - NAVIGASI KE EDIT ACCOUNT PAGE
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigasi ke halaman Edit Account
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const EditAccountPage(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2E8B8B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       child: const Text(
//                         'Edit Profile',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Tombol Logout
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _showLogoutDialog(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2E8B8B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       child: const Text(
//                         'Logout',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Tombol Delete Account
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _showDeleteAccountDialog(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2E8B8B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       child: const Text(
//                         'Delete Account',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),

//       // Bottom Navigation Bar (TERPISAH)
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: 3, // Profile aktif (index 3)
//         onTap: (index) {
//           if (index == 0) {
//             // Navigate ke Home
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => const HomePage()),
//               (route) => false,
//             );
//           } else if (index == 1) {
//             // Navigate ke Explore
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => const ExplorePage()),
//               (route) => false,
//             );
//           } else if (index == 2) {
//             // Ticket page belum ada
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Halaman Ticket segera hadir!')),
//             );
//           } else if (index == 3) return; // Sudah di Profile
//         },
//       ),
//     );
//   }

//   // Widget untuk Form Field Profile
//   Widget _buildProfileField(String label) {
//     return Container(
//       width: double.infinity,
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: const Color(0xFFBDBDBD), // Abu-abu
//         borderRadius: BorderRadius.circular(25),
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         label,
//         style: const TextStyle(
//           color: Colors.black87,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   // Dialog Logout → mengarah ke LoginPage
//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           contentPadding: const EdgeInsets.all(24),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Apakah anda yakin untuk Logout Akun?',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   // Yes Button (Lime Green) → ke LoginPage
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Hapus semua halaman di stack, lalu arahkan ke LoginPage
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoginPage(),
//                           ),
//                           (route) => false,
//                         );
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Berhasil logout')),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFC5E618),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         elevation: 0,
//                       ),
//                       child: const Text(
//                         'Yes',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   // NO Button (Merah) → tutup dialog
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         elevation: 0,
//                       ),
//                       child: const Text(
//                         'NO',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Dialog Delete Account → mengarah ke WelcomePage
//   void _showDeleteAccountDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           contentPadding: const EdgeInsets.all(24),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Apakah anda yakin untuk Delete Akun?',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   // Yes Button (Lime Green) → ke WelcomePage
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Hapus semua halaman di stack, lalu arahkan ke WelcomePage
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const WelcomePage(),
//                           ),
//                           (route) => false,
//                         );
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Akun berhasil dihapus')),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFC5E618),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         elevation: 0,
//                       ),
//                       child: const Text(
//                         'Yes',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   // NO Button (Merah) → tutup dialog
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         elevation: 0,
//                       ),
//                       child: const Text(
//                         'NO',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'edit_akun_page.dart';
import 'login_page.dart';
import 'welcome_page.dart';
import '../config/api_config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Panggil fungsi API saat halaman pertama kali dibuka
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
                      onPressed: () => Navigator.pop(context),
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
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ExplorePage()),
              (route) => false,
            );
          } else if (index == 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Halaman Ticket segera hadir!')),
            );
          } else if (index == 3)
            return;
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
                      onPressed: () async {
                        // Hapus Token dari memori HP
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('token');
                        await prefs.remove('user_name');

                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Berhasil logout')),
                          );
                        }
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
    // ... (Kode _showDeleteAccountDialog Anda dibiarkan sama seperti sebelumnya)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
                        // Opsional: Panggil API delete account di sini nantinya
                        // Bersihkan token
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('token');

                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomePage(),
                            ),
                            (route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Akun berhasil dihapus'),
                            ),
                          );
                        }
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
                      onPressed: () => Navigator.pop(context),
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
