import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'event_page.dart';
import 'profile_page.dart';

class GaleriPage extends StatelessWidget {
  const GaleriPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> galleryItems = [
      {
        'title': 'Danau Weekuri',
        'image': 'assets/images/weekuri.jpg',
      },
      {
        'title': 'Gunung Rinjani',
        'image': 'assets/images/rinjani.jpg',
      },
      {
        'title': 'Candi Prambanan',
        'image': 'assets/images/prambanan.jpg',
      },
      {
        'title': 'Monumen Nasional\n(Monas)',
        'image': 'assets/images/monas.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      body: Column(
        children: [
          // HEADER
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bgfix2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(
                height: 250,
                color: Colors.black.withOpacity(0.25),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 80,
                      ),

                      const SizedBox(height: 35),

                      const Text(
                        'Galleri',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(18),
              child: GridView.builder(
                itemCount: galleryItems.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final item = galleryItems[index];

                  return Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            item['image']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.image,
                                  size: 50,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
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
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const EventPage(),
              ),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}