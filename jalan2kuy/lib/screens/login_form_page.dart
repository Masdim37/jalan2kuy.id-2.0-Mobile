import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({Key? key}) : super(key: key);

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final TextEditingController _usernameController =
      TextEditingController(); // Atau username
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Untuk indikator loading

  // 2. Fungsi utama untuk memanggil API Laravel
  Future<void> loginKeApi() async {
    setState(() {
      _isLoading = true;
    });

    // PENTING: Aturan IP Address
    // Jika pakai Android Emulator, gunakan '10.0.2.2'
    // Jika pakai HP Fisik, gunakan IP Address laptop Anda (misal: '192.168.1.x')
    final String url = 'http://192.168.1.40:8000/api/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json', // Pastikan mengirim format JSON
        },
        body: jsonEncode({
          'username': _usernameController
              .text, // Ganti 'username' jika API Anda memakai username
          'password': _passwordController.text,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // 3. Jika Sukses, simpan Token ke memori HP
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['token']);

        // Opsional: Simpan juga data user misal nama
        await prefs.setString('user_name', responseData['data']['nameUser']);

        // 4. Pindah ke halaman Home (dan tidak bisa diback ke halaman login)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ), // Sesuaikan dengan halaman utama Anda
        );
      } else {
        // Jika gagal (password salah, dll), tampilkan pesan error dari Laravel
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Login gagal')),
        );
      }
    } catch (e) {
      print("ERROR LOGIN: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Warna hijau gelap dari desain jalan2kuy
  final Color primaryGreen = const Color(0xFF1E4E42);

  // State untuk mengontrol tampil/sembunyi password
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false, // Penting agar tidak error saat keyboard muncul
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- 1. Tombol Back ---
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back_ios, color: Colors.blue, size: 20),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- 2. Judul & Sub-judul ---
                    const Text(
                      'Silahkan Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Font warna hitam
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Silahkan login untuk melanjutkan ke aplikasi.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- 3. Input Username ---
                    TextField(
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- 4. Input Password dengan Ikon Mata ---
                    TextField(
                      obscureText: _isObscure, // Dikontrol oleh state
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        // Menambahkan ikon di sebelah kanan form
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            // Mengubah state saat ikon mata ditekan
                            setState(() {
                              _isObscure = !_isObscure; 
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- 5. Forgot Password & Buat Akun ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol Buat Akun
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Buat Akun',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // Tombol Lupa Password
                        TextButton(
                          onPressed: () {
                            // Aksi Lupa Password
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Lupa password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Spacer: Mendorong elemen di bawahnya agar mentok ke bawah layar
                    const Spacer(),

                    // --- 6. Tombol Continue ---
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16), 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
