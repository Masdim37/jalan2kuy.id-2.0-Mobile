import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'event_page.dart';
import 'profile_page.dart';
<<<<<<< HEAD
import 'event_detail_page.dart';
import 'ticket_beli_page.dart';
=======
>>>>>>> fd2f0b2a6b3e0eb12d2399e705e5480b8071fe2e

class EventDetailPage extends StatelessWidget {
  // Changed from Map<String, String> to Map<String, dynamic> to accept DateTime types
  final Map<String, dynamic> event;

  const EventDetailPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      extendBody: true,

      body: Stack(
        children: [
          // ================= HEADER IMAGE =================
          SizedBox(
            height: 280,
            width: double.infinity,
            child: Image.asset(
              event['image'].toString(), // Safely convert dynamic to string
              fit: BoxFit.cover,
            ),
          ),

          // Overlay
          Container(
            height: 280,
            color: Colors.black.withOpacity(0.35),
          ),

          // ================= HEADER CONTENT =================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    event['title']?.toString() ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ================= DETAIL CARD =================
          Positioned(
            top: 240,
            left: 16,
            right: 16,
            bottom: 90, // ruang untuk bottom nav
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            event['image'].toString(),
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/bgfix2.jpg',
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      event['location']?.toString() ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // String interpolation handles DateTime objects smoothly here
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Tanggal : ${event['date']}"),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Jam : ${event['time']}"),
                  ),

                  const SizedBox(height: 6),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Harga Tiket : ${event['price']}",
                      style: const TextStyle(
                        color: Color(0xFF0B8B62),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        event['description']?.toString() ?? '',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(height: 1.6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketBeliPage(event: event),
                            ),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF17C3A5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Beli Tiket (${event['price']})",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ================= BOTTOM NAVIGATION =================
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const EventPage()),
              (route) => false,
            );
          } else if (index == 3) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}