import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'profile_page.dart';
import 'destination_detail_page.dart';

class CategoryDetailPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final String categoryImage;

  const CategoryDetailPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  }) : super(key: key);

  // Data destinasi berdasarkan kategori (sesuai database)
  // Sudah ditambahkan field 'image' untuk gambar utama
  List<Map<String, dynamic>> _getDestinations() {
    switch (categoryId) {
      case 'ctg001': // Nature
        return [
          {
            'id': 'dst001',
            'name': 'Danau Weekuri',
            'image': 'destinations/image/GxXfM0rt0mQeK9pdjsHN86t3JPNqwT4vbVFN5FKe.jpg',
            'thumbnail': 'destinations/thumbnailImage/OkEpL8NHoapcX1k2tO80pouSNsSrpmTatzFoEUGG.jpg',
          },
          {
            'id': 'dst002',
            'name': 'Gunung Rinjani',
            'image': 'destinations/image/9G19cn2KNqscnTcfKmeMfUDPPhNJh3jS8yUfVyRE.jpg',
            'thumbnail': 'destinations/thumbnailImage/Jru103JQPunexa2hZ07NjXkf38grIJbhEqiB1Skj.jpg',
          },
          {
            'id': 'dst003',
            'name': 'Bukit Merese',
            'image': 'destinations/image/FWQjn3D35MjH1HNRbMH7zUNuaFs5DyqgaKeYmAQG.jpg',
            'thumbnail': 'destinations/thumbnailImage/x9mHJgSmPAkPzq2g0xz21k9M2ra2SAyK2xO7deId.jpg',
          },
        ];
      case 'ctg002': // History
        return [
          {
            'id': 'dst004',
            'name': 'Candi Borobudur',
            'image': 'destinations/image/wKVMGKiZSh4eAo7NRgKYbNNELSImoYhDIu8IWLLr.jpg',
            'thumbnail': 'destinations/thumbnailImage/Z6NOINhNtQgb0N3sWAGYSyNypnjBI3RAvw2DmbBD.jpg',
          },
          {
            'id': 'dst005',
            'name': 'Candi Prambanan',
            'image': 'destinations/image/sBBVjGZmm7rcwaMEUfYQsIqz2h3Cw4M1Awz1im11.jpg',
            'thumbnail': 'destinations/thumbnailImage/gTAnjdweyCpBtco74SYQCwrRBL8lDFm1A59fHIg8.jpg',
          },
          {
            'id': 'dst006',
            'name': 'Monumen Nasional',
            'image': 'destinations/image/xVCHrIeT3XCUXnwJGXGu2CqOENFKa3NtilsMJChU.jpg',
            'thumbnail': 'destinations/thumbnailImage/HDGNRxBmmj7ZBTEblAcFJD1FBqfgD7TQTSJEb6wA.jpg',
          },
        ];
      case 'ctg003': // Ecotourism
        return [
          {
            'id': 'dst007',
            'name': 'Taman Nasional Komodo',
            'image': 'destinations/image/Qk6YfPAJv0Rm9Zfxd9xt7H6FKnCjQwnii06oPs32.jpg',
            'thumbnail': 'destinations/thumbnailImage/PT03feKTeO3vsJJvalQtoGwRmdrUZaiFvEZuVPom.jpg',
          },
          {
            'id': 'dst008',
            'name': 'Taman Nasional Way Kambas',
            'image': 'destinations/image/5Dt7dJtSib8icUfgrPUeBxQ3EyaggRuR5FP6e2XQ.jpg',
            'thumbnail': 'destinations/thumbnailImage/DFkBTafMCmWiosOjBNMK1ho8Gwtz6BJCbq8jrLnZ.jpg',
          },
          {
            'id': 'dst009',
            'name': 'Taman Nasional Gunung Leuser',
            'image': 'destinations/image/bhbPy3iv8bk87U0HhkBfqT2xjalK3FVq4aV0DQbo.jpg',
            'thumbnail': 'destinations/thumbnailImage/j3QrCUrG63dmcnZiPc6F2fjROSJKnhJiKwZkiHlq.jpg',
          },
        ];
      case 'ctg004': // Beach
        return [
          {
            'id': 'dst010',
            'name': 'Pantai Ora',
            'image': 'destinations/image/DpA9IBCR3YWQyBAg73nFP0lHAZQ4UfKXk2x2X3di.jpg',
            'thumbnail': 'destinations/thumbnailImage/bIHGbHujlZUTuX4rWldrGCp3fZiyrYT77SHlPGLT.jpg',
          },
          {
            'id': 'dst011',
            'name': 'Pantai Gatra',
            'image': 'destinations/image/4RtZb1cYOMCbCaOyXoAf3PvWvZp8IhT8DyLvpaIi.jpg',
            'thumbnail': 'destinations/thumbnailImage/MSm9GPXifxGZERHqt2CnKIoZPjlw1fURYMPskF9c.jpg',
          },
          {
            'id': 'dst012',
            'name': 'Pantai Tanjung Aan',
            'image': 'destinations/image/QG9zj5k4xv3rv6aecwwWHmjvfk40Jt4LVh0LBoW0.jpg',
            'thumbnail': 'destinations/thumbnailImage/rMyHmuAOtczUFlqBYJ9ifXtSfxFRxccrtCIefZ15.jpg',
          },
        ];
      case 'ctg005': // Culture
        return [
          {
            'id': 'dst013',
            'name': 'Floating Market Lembang',
            'image': 'destinations/image/EpqU8kp68a7ClpZ9Iyki9GB6eJXdzm4oxwUbpdnP.jpg',
            'thumbnail': 'destinations/thumbnailImage/w422Ql7Bz1AOt0LA5RIgOjDeLd5RI6rfSjUu7C6.jpg',
          },
          {
            'id': 'dst014',
            'name': 'Pura Tanah Lot',
            'image': 'destinations/image/rz8lBEboJwppwDyvQ3mEsopp6WEaJZGgIWXXZB0B.jpg',
            'thumbnail': 'destinations/thumbnailImage/NgU9JGjROBpJ6RURuDBLfiE3wcAmYpsjj0Pio8D4.jpg',
          },
          {
            'id': 'dst015',
            'name': 'Kampung Cina Jakarta',
            'image': 'destinations/image/XsvCTjWGMvS5CPrT6QMOZBmKZMIOgkO1KpV8Ga7C.jpg',
            'thumbnail': 'destinations/thumbnailImage/J5kk3yPWr4THwVkGWftebT7nMKgbSRbwVDEzDPD8.jpg',
          },
        ];
      case 'ctg006': // Education
        return [
          {
            'id': 'dst016',
            'name': 'Taman Ismail Marzuki',
            'image': 'destinations/image/n9e7PuYSxMelsAEIKTAZtnbY6lBZhk79EIAhYaUh.jpg',
            'thumbnail': 'destinations/thumbnailImage/WBYNzgEkEzKPGnowwduq3rU8AoCccA3RENUAzY7t.jpg',
          },
          {
            'id': 'dst017',
            'name': 'Taman Mini Indonesia Indah',
            'image': 'destinations/image/3QYI1OL5f7PODfNGs0RPxjVMjr6oPydlI1XA9Tua.jpg',
            'thumbnail': 'destinations/thumbnailImage/CBRkIdizkkgWiw8aU0o9hU8onrHjiLRM7jI8IYa3.jpg',
          },
          {
            'id': 'dst018',
            'name': 'Museum Pengkhianatan PKI',
            'image': 'destinations/image/fJn0FmdfucsZlZtjg17yJQZ3Ija2INERmSeohNDB.jpg',
            'thumbnail': 'destinations/thumbnailImage/LBGwYG2UoN27KMCTkwuXR0F6k7ER0Z2cfnCgS7Zg.jpg',
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final destinations = _getDestinations();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header dengan Background Gambar Kategori
          Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(categoryImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo & Nama App
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Judul Kategori
                      Text(
                        categoryName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Search Bar
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari destinasi yang ingin dituju...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // List Destinasi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final destination = destinations[index];
                return _buildDestinationCard(context, destination);
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1, // Explore aktif
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
          } else if (index == 3) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
              (route) => false,
            );
          }
        },
      ),
    );
  }

  // Card Destinasi - HANYA GAMBAR + NAMA
  Widget _buildDestinationCard(BuildContext context, Map<String, dynamic> destination) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail destinasi
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailPage(
              destinationId: destination['id']!,
              destinationName: destination['name']!,
              destinationImage: destination['image']!,
              destinationThumbnail: destination['thumbnail']!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gambar Destinasi
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/${destination['thumbnail']}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika gambar tidak ditemukan
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade400,
                          Colors.grey.shade300,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 60,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            // Overlay Gelap
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Nama Destinasi di Tengah
            Center(
              child: Text(
                destination['name']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}