import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'event_detail_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final List<Map<String, String>> events = [
    {
      'title': 'SENDRATARI RAMAYANA PRAMBANAN',
      'date': '01 November 2025',
      'time': '18.00',
      'location': 'Gedung Trimurti, Candi Prambanan',
      'description':
          'Persembahan budaya yang megah, Sendratari Ramayana Prambanan adalah sebuah mahakarya yang memukau.',
      'price': 'Rp 150.000',
      'image': 'assets/events/event1.jpg',
    },
    {
      'title': 'SAMBUT ENERGI POSITIF DI TENGAH KEAGUNGAN CANDI BOROBUDUR',
      'date': '22 Agustus 2025',
      'time': '07.30',
      'location': 'Borobudur Cultural Center',
      'description':
          'Ruang penyembuhan dan ketenangan yang memadukan suasana spiritual Candi Borobudur yang sakral.',
      'price': 'Gratis',
      'image': 'assets/events/event2.jpg',
    },
    {
      'title': 'SORAK SORAI FEST 2026',
      'date': '19 Desember 2025',
      'time': '19.00',
      'location': 'Borobudur Cultural Center',
      'description':
          'Sorak Sorai Fest adalah festival musik yang menggabungkan konser dan seni visual.',
      'price': 'Rp 100.000',
      'image': 'assets/events/event3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      body: Column(
        children: [
          // HEADER
          Stack(
            children: [
              Container(
                height: 220,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bgfix2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 220,
                color: Colors.black.withOpacity(0.25),
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png', width: 80),
                      const SizedBox(height: 20),
                      const Text(
                        'Event',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 55),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _dateChip("01/11/25"),
                          const SizedBox(width: 12),
                          _dateChip("30/12/25"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // LIST EVENT
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailPage (event: event),
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
                          child: Image.asset(
                            event['image']!,
                            width: 90,
                            height: 115,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E5A4E),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  event['title']!,
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
                                "${event['date']} | ${event['time']}",
                                style: const TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                event['location']!,
                                style: const TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 6),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  event['price']!,
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

  Widget _dateChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFDDE8D8),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(text),
    );
  }
}