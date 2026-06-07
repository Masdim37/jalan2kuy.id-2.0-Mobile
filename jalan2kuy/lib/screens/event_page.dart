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
  DateTime? startDate;
  DateTime? endDate;

  final List<Map<String, dynamic>> events = [
    {
      'title': 'SENDRATARI RAMAYANA PRAMBANAN',
      'date': DateTime(2025, 11, 1),
      'time': '18.00',
      'location': 'Gedung Trimurti, Candi Prambanan',
      'description': 'Sendratari Ramayana Prambanan.',
      'price': 'Rp 150.000',
      'image': 'assets/event/ramayana.jpg',
    },
    {
      'title': 'MEDITATION BOROBUDUR',
      'date': DateTime(2025, 8, 22),
      'time': '07.30',
      'location': 'Borobudur Cultural Center',
      'description': 'Meditasi spiritual di Borobudur.',
      'price': 'Gratis',
      'image': 'assets/event/MEDITATION.jpg',
    },
    {
      'title': 'SORAK SORAI FEST 2026',
      'date': DateTime(2025, 12, 19),
      'time': '19.00',
      'location': 'Borobudur Cultural Center',
      'description': 'Festival musik.',
      'price': 'Rp 100.000',
      'image': 'assets/event/sorai.jpg',
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    if (startDate == null || endDate == null) return events;

    return events.where((event) {
      final eventDate = event['date'] as DateTime;
      return eventDate.isAfter(startDate!.subtract(const Duration(days: 1))) &&
          eventDate.isBefore(endDate!.add(const Duration(days: 1)));
    }).toList();
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--/--/--';
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      body: Column(
        children: [
          // ================= HEADER =================
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                      const SizedBox(height: 40),

                      /// DATE PICKER
                      GestureDetector(
                        onTap: _pickDateRange,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _dateChip(_formatDate(startDate)),
                            const SizedBox(width: 12),
                            _dateChip(_formatDate(endDate)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ================= LIST EVENT =================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailPage(
                          event: {
                            ...event,
                            'date': _formatDate(event['date']),
                          },
                        ),
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
                            event['image'],
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
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E5A4E),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  event['title'],
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
                                "${_formatDate(event['date'])} | ${event['time']}",
                                style: const TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                event['location'],
                                style: const TextStyle(fontSize: 10),
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
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