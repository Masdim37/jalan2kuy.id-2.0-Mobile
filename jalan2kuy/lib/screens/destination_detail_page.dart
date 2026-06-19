import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'profile_page.dart';

class DestinationDetailPage extends StatefulWidget {
  final String destinationID;
  final String destinationName;
  final String destinationThumbnail;

  const DestinationDetailPage({
    Key? key,
    required this.destinationID,
    required this.destinationName,
    required this.destinationThumbnail,
  }) : super(key: key);

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  Map<String, dynamic>? destinationDetail;
  Map<String, dynamic>? relatedEvent;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDestinationDetail();
  }

  // Fungsi untuk mengambil data detail destinasi dari API Laravel
  Future<void> fetchDestinationDetail() async {
    setState(() => isLoading = true);

    try {
      // Pastikan endpoint ini sesuai dengan yang Anda buat di Laravel
      // Contoh: http://192.168.1.40:8000/api/destination/detail?destinationID=dst001
      String url =
          '${ApiConfig.destinationDetail}?destinationID=${widget.destinationID}';

      print("🌍 MENGHUBUNGI URL: $url");

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

      // CCTV 2: Lihat status balasan dari Laravel
      print("🚀 STATUS CODE: ${response.statusCode}");
      // CCTV 3: Lihat isi JSON yang ditangkap Flutter
      print("📦 ISI RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // CCTV 4: Pastikan status success-nya true
        print("✅ SUCCESS STATUS: ${responseData['success']}");

        setState(() {
          destinationDetail = responseData['destination'];
          relatedEvent = responseData['event'];
          isLoading = false;
        });
      } else {
        print("❌ GAGAL! SERVER MERESPON: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("🚨 KONEKSI ERROR (MUNGKIN SALAH IP): $e");
      print("Error fetching detail: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Jika masih loading, tampilkan indikator
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF1B5E5E)),
        ),
      );
    }

    // Jika data tidak ditemukan setelah API dipanggil
    if (destinationDetail == null || destinationDetail!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Destinasi Tidak Ditemukan'),
          backgroundColor: const Color(0xFF1B5E5E),
        ),
        body: const Center(child: Text('Data destinasi tidak ditemukan')),
      );
    }

    // Membentuk URL gambar dari data API (Gunakan fallback image dari widget jika API kosong)
    // final String imagePath = destinationDetail?['imagePath'] ?? '';
    // final String thumbnailPath = destinationDetail?['thumbnailImagePath'] ?? '';

    // final String selectedPath = imagePath.isNotEmpty ? imagePath : thumbnailPath;

    // final String headerImageUrl = '${ApiConfig.storageUrl}/$selectedPath';

    // 1. Ambil path dari API
    final String rawImagePath = destinationDetail?['imagePath'] ?? '';
    final String rawThumbnailPath =
        destinationDetail?['thumbnailImagePath'] ?? '';

    // 2. Buat URL utuh untuk keduanya
    final String headerImageUrl = rawImagePath.isNotEmpty
        ? '${ApiConfig.storageUrl}/$rawImagePath'
        : ''; // Kosongkan jika tidak ada

    final String thumbnailImageUrl = rawThumbnailPath.isNotEmpty
        ? '${ApiConfig.storageUrl}/$rawThumbnailPath'
        : '';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header dengan Background Gambar Destinasi
          Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  headerImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey.shade400),
                ),
              ),
              Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tombol Back & Logo
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Judul Destinasi
                      Text(
                        destinationDetail?['name'] ??
                            destinationDetail?['nameDestination'] ??
                            widget.destinationName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Konten Detail
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Card
                  _buildInfoCard(destinationDetail!, relatedEvent),
                  const SizedBox(height: 20),
                  // Deskripsi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    destinationDetail?['description'] ??
                        'Deskripsi belum tersedia.',
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
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

  // Info Card dengan gambar, lokasi, jam, harga, dan event
  Widget _buildInfoCard(
    Map<String, dynamic> destination,
    Map<String, dynamic>? event,
  ) {
    final String rawThumbnailPath =
        destinationDetail?['thumbnailImagePath'] ?? '';

    final String thumbnailImageUrl = rawThumbnailPath.isNotEmpty
        ? '${ApiConfig.storageUrl}/$rawThumbnailPath'
        : '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gambar Thumbnail (Network)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              thumbnailImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade400, Colors.grey.shade300],
                    ),
                  ),
                  child: const Icon(
                    Icons.broken_image,
                    size: 60,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          // Info Detail
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lokasi
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.black87,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        destination['location'] ?? 'Lokasi tidak tersedia',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Jam Operasional
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.black87,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${destination['openingDay'] ?? '-'} - ${destination['closingDay'] ?? '-'}\n(${destination['openingHours'] ?? '-'} - ${destination['closingHours'] ?? '-'} ${destination['timezone'] ?? ''})',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Harga Tiket
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: Colors.black87,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      destination['entranceFee'] == null ||
                              destination['entranceFee'] == 0
                          ? 'Gratis'
                          : 'Rp ${_formatRupiah(destination['entranceFee'])}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Jika event tersedia, tampilkan
                if (event != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B5E5E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Event Terkait',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['name'] ?? 'Event',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_formatDate(event['startDate'] ?? '')} - ${_formatDate(event['endDate'] ?? '')}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Format Rupiah
  String _formatRupiah(dynamic amount) {
    int parsedAmount = amount is int
        ? amount
        : int.tryParse(amount.toString()) ?? 0;
    return parsedAmount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  // Format Date (YYYY-MM-DD to DD MMM YYYY)
  String _formatDate(String dateString) {
    if (dateString.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateString);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'Mei',
        'Jun',
        'Jul',
        'Agu',
        'Sep',
        'Okt',
        'Nov',
        'Des',
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
