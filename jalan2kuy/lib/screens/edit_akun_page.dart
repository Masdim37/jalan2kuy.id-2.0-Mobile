import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart'; // Pastikan path ini benar
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  // Warna hijau gelap
  final Color primaryGreen = const Color(0xFF1B5E5E);

  // Controller untuk TextField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  bool _isObscurePassword = true;
  bool _isFetching = true;
  bool _isSaving = false;

  // Dropdown value
  String? _selectedGender;
  final List<String> _genderOptions = ['Laki-laki', 'Perempuan'];

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserData(); // Ambil data saat halaman pertama kali dimuat
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _fetchCurrentUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) return;

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.account),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Connection': 'keep-alive',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        setState(() {
          _nameController.text = data['nameUser']?.toString() ?? '';
          _emailController.text = data['email']?.toString() ?? '';
          _usernameController.text = data['username']?.toString() ?? '';

          // Sesuaikan 'phone' dengan field di database (misal 'notelp')
          _phoneController.text =
              data['phone']?.toString() ?? data['notelp']?.toString() ?? '';

          // Mengatur Dropdown Gender (Asumsi 1/true = Laki-laki, 0/false = Perempuan)
          if (data['gender'] == 1 ||
              data['gender'] == true ||
              data['gender'] == '1') {
            _selectedGender = 'Laki-laki';
          } else if (data['gender'] == 0 ||
              data['gender'] == false ||
              data['gender'] == '0') {
            _selectedGender = 'Perempuan';
          }

          // Mengatur Tanggal Lahir (Dari YYYY-MM-DD ke DD/MM/YYYY)
          if (data['birthDate'] != null) {
            String dbDate = data['birthDate'].toString().substring(0, 10);
            List<String> parts = dbDate.split('-');
            if (parts.length == 3) {
              _birthDateController.text = "${parts[2]}/${parts[1]}/${parts[0]}";
            }
          }
          _isFetching = false;
        });
      }
    } catch (e) {
      setState(() => _isFetching = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memuat data profil')),
        );
      }
    }
  }

  // --- 2. FUNGSI MENYIMPAN PERUBAHAN KE API ---
  Future<void> _saveProfileChanges() async {
    setState(() => _isSaving = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // Ubah format tanggal dari DD/MM/YYYY (UI) kembali ke YYYY-MM-DD (Laravel)
    String formattedDate = '';
    if (_birthDateController.text.isNotEmpty) {
      List<String> parts = _birthDateController.text.split('/');
      if (parts.length == 3)
        formattedDate = "${parts[2]}-${parts[1]}-${parts[0]}";
    }

    // Ubah teks gender kembali ke format yang diterima Laravel (misal 1 dan 0)
    String genderVal = _selectedGender == 'Laki-laki' ? '1' : '0';

    // Siapkan body request
    Map<String, dynamic> bodyData = {
      'nameUser': _nameController.text,
      'email': _emailController.text,
      'username': _usernameController.text,
      'phone': _phoneController.text,
      'gender': genderVal,
      'birthDate': formattedDate,
    };

    // Jika password diisi, tambahkan ke request. Jika tidak, abaikan agar tidak menimpa dengan string kosong.
    if (_passwordController.text.isNotEmpty) {
      bodyData['password'] = _passwordController.text;
    }

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.editAccount),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(bodyData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil berhasil diperbarui')),
          );
          // Kembali ke halaman sebelumnya dan kirim sinyal 'true' agar ProfilePage tahu harus refresh data
          Navigator.pop(context, true);
        }
      } else {
        // Tampilkan pesan error validasi dari Laravel
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                responseData['message'] ?? 'Gagal menyimpan perubahan',
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terjadi kesalahan jaringan')),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  // Fungsi untuk menampilkan date picker dengan tema hijau
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1B5E5E),
              onPrimary: Colors.white,
              onSurface: Colors.black,
              surface: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF1B5E5E),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Color(0xFF1B5E5E)),
          ),
          child: child!,
        );
      },
      initialDatePickerMode: DatePickerMode.day,
    );

    if (picked != null) {
      setState(() {
        String day = picked.day.toString().padLeft(2, '0');
        String month = picked.month.toString().padLeft(2, '0');
        String year = picked.year.toString();
        _birthDateController.text = "$day/$month/$year";
      });
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
            decoration: const BoxDecoration(color: Color(0xFF1B5E5E)),
            child: Column(
              children: [
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
                  'Edit Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Konten Form
          Expanded(
            child: _isFetching
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
                        _buildEditableField('Nama Lengkap', _nameController),
                        const SizedBox(height: 12),
                        _buildEditableField(
                          'Email',
                          _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        _buildEditableField('Username', _usernameController),
                        const SizedBox(height: 12),
                        _buildPasswordField(),
                        const SizedBox(height: 12),
                        _buildDropdownField(),
                        const SizedBox(height: 12),
                        _buildEditableField(
                          'Masukkan nomor HP',
                          _phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        _buildDatePickerField(),
                        const SizedBox(height: 25),

                        // Tombol Save Change
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: _isSaving
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF1B5E5E),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed:
                                      _saveProfileChanges, // Panggil fungsi API POST
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E8B8B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    'Save Change',
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

      // Bottom Navigation Bar (TERPISAH)
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3, // Profile aktif (karena ini sub-halaman Profile)
        onTap: (index) {
          if (index == 0) {
            // Navigate ke Home
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          } else if (index == 1) {
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
            // Kembali ke ProfilePage
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  // Widget untuk Form Field yang bisa di-edit (TextField)
  Widget _buildEditableField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: const Color(0xFF1B5E5E),
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // Widget untuk Password Field dengan icon mata
  Widget _buildPasswordField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: _isObscurePassword,
        cursorColor: const Color(0xFF1B5E5E),
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Password (Isi hanya jika ingin mengganti password)',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isObscurePassword = !_isObscurePassword;
              });
            },
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ),
    );
  }

  // Widget untuk Dropdown Field
  Widget _buildDropdownField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedGender,
          hint: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Pilih jenis kelamin',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          isExpanded: true,
          icon: const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
              size: 24,
            ),
          ),
          items: _genderOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedGender = newValue;
            });
          },
        ),
      ),
    );
  }

  // Widget untuk Date Picker Field
  Widget _buildDatePickerField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _birthDateController,
        readOnly: true,
        cursorColor: const Color(0xFF1B5E5E),
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'dd/mm/yyyy',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: Colors.grey,
            size: 20,
          ),
        ),
        onTap: _selectDate,
      ),
    );
  }
}
