import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'event_detail_page.dart';
import 'event_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<dynamic> apiEvents = [];
  bool isLoading = true;

  // Variabel untuk menyimpan tanggal yang dipilih user
  DateTime? tanggalMulai;
  DateTime? tanggalSelesai;

  @override
  void initState() {
    super.initState();
    fetchEvents(); // Pertama kali dibuka, ambil semua data tanpa filter tanggal
  }

  // Fungsi fetch API yang menerima parameter tanggal (Opsional)
  Future<void> fetchEvents({String? startDate, String? endDate}) async {
    setState(() => isLoading = true);

    // 1. Menyusun URL awal
    String url = ApiConfig.event; // Misal: https://.../api/event

    // 2. Jika tanggal diisi, tambahkan query parameters ?start_date=...&end_date=...
    if (startDate != null && endDate != null) {
      url += '?start_date=$startDate&end_date=$endDate';
    }

    print("🌍 MENGHUBUNGI URL EVENT: $url");

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Connection': 'keep-alive',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          apiEvents = responseData['data'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("🚨 Error fetch events: $e");
      setState(() => isLoading = false);
    }
  }

  // Fungsi memilih Tanggal Mulai
  Future<void> _pilihTanggalMulai() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggalMulai ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2028),
      helpText: 'Pilih Tanggal Mulai',
    );

    if (picked != null) {
      setState(() {
        tanggalMulai = picked;
      });
      // Panggil API jika kedua tanggal sudah terisi
      _cekDanKirimFilter();
    }
  }

  // Fungsi memilih Tanggal Selesai
  Future<void> _pilihTanggalSelesai() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggalSelesai ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2028),
      helpText: 'Pilih Tanggal Selesai',
    );

    if (picked != null) {
      setState(() {
        tanggalSelesai = picked;
      });
      // Panggil API jika kedua tanggal sudah terisi
      _cekDanKirimFilter();
    }
  }

  // Fungsi pembantu untuk memicu fetch API ke Laravel
  void _cekDanKirimFilter() {
    if (tanggalMulai != null && tanggalSelesai != null) {
      String formattedStart = DateFormat('yyyy-MM-dd').format(tanggalMulai!);
      String formattedEnd = DateFormat('yyyy-MM-dd').format(tanggalSelesai!);
      fetchEvents(startDate: formattedStart, endDate: formattedEnd);
    }
  }

  // Fungsi mereset filter tanggal
  void _resetFilterTanggal() {
    setState(() {
      tanggalMulai = null;
      tanggalSelesai = null;
    });
    fetchEvents(); // Muat ulang semua data awal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      body: Column(
        children: [
          // HEADER
          // HEADER DENGAN CHIP TERPISAH YANG FLOATING
          Stack(
            clipBehavior: Clip
                .none, // Agar kedua chip bisa melayang keluar kontainer header
            children: [
              // 1. Background Gambar
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bgfix2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(height: 50, color: Colors.black.withOpacity(0.25)),

              // 2. Konten Header (Logo & Judul Desain Asli Anda)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/logo.png', width: 80),
                          // Tombol reset filter muncul jika salah satu tanggal terisi
                          if (tanggalMulai != null || tanggalSelesai != null)
                            IconButton(
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              onPressed: _resetFilterTanggal,
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Event',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ), // Jarak diatur agar memberi ruang seimbang
                    ],
                  ),
                ),
              ),

              // 3. KEDUA CHIP MELAYANG (FLOATING) DI TENGAH BAWAH HEADER
              Positioned(
                bottom:
                    -22, // Membuat kedua chip menggantung melayang setengah badan ke bawah
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Chip Pertama: Tanggal Mulai
                    GestureDetector(
                      onTap: _pilihTanggalMulai,
                      child: _dateChip(
                        tanggalMulai == null
                            ? "Tanggal Mulai\n(DD/MM/YYYY)"
                            : DateFormat('dd/MM/yy').format(tanggalMulai!),
                        isFiltered: tanggalMulai != null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Chip Kedua: Tanggal Selesai
                    GestureDetector(
                      onTap: _pilihTanggalSelesai,
                      child: _dateChip(
                        tanggalSelesai == null
                            ? "Tanggal Selesai\n(DD/MM/YYYY)"
                            : DateFormat('dd/MM/yy').format(tanggalSelesai!),
                        isFiltered: tanggalSelesai != null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 35),
          // LIST EVENT DARI API LARAVEL
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: apiEvents
                  .length, // Menggunakan variabel state list event API Anda
              itemBuilder: (context, index) {
                final event = apiEvents[index];

                // Integrasi URL Gambar dari API Laravel
                String rawImagePath =
                    event['imagePath'] ?? event['image'] ?? '';
                final String imageUrl = '${ApiConfig.storageUrl}/$rawImagePath';

                // Format tampilan harga dari database
                dynamic fee = event['entranceFee'];
                String priceText = (fee == 0 || fee == null)
                    ? 'Gratis'
                    : 'Rp $fee';

                String startRaw = event['startDate'] ?? event['date'] ?? '-';
                String endRaw = event['endDate'] ?? event['date'] ?? '-';

                // Memotong huruf 'T' (bawaan Laravel) ATAU spasi sekaligus, lalu ambil bagian depannya saja [0]
                String startDateOnly = startRaw.split('T')[0].split(' ')[0];
                String endDateOnly = endRaw.split('T')[0].split(' ')[0];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailPage(event: event),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          // Mengubah Image.asset menjadi Image.network untuk memuat dari server
                          child: Image.network(
                            imageUrl,
                            width: 90,
                            height: 115,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 90,
                                height: 115,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E5A4E),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  event['name'] ??
                                      event['title'] ??
                                      '-', // Disesuaikan dengan key API
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "$startDateOnly - $endDateOnly",
                                style: const TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                event['location'] ?? '-',
                                style: const TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 6),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  priceText,
                                  style: const TextStyle(
                                    color: Color(0xFF0B8B62),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }

  Widget _dateChip(String text, {bool isFiltered = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        // Jika sudah terfilter warnanya bisa sedikit membedakan (opsional)
        color: isFiltered ? const Color(0xFFCBE2C1) : const Color(0xFFDDE8D8),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(
              0,
              4,
            ), // Efek bayangan halus agar terlihat melayang nyata
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          height: 1.3, // Mengatur jarak renggang baris teks \n
        ),
      ),
    );
  }
}
