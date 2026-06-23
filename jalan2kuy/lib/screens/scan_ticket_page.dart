import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class ScanTicketPage extends StatefulWidget {
  const ScanTicketPage({Key? key}) : super(key: key);

  @override
  State<ScanTicketPage> createState() => _ScanTicketPageState();
}

class _ScanTicketPageState extends State<ScanTicketPage> {
  bool isProcessing = false;

  Future<void> verifyTicket(String tiketID) async {
    if (isProcessing) return; // Mencegah scan berulang
    setState(() => isProcessing = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.scanTicket}/$tiketID'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      );

      final data = jsonDecode(response.body);
      
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text(data['success'] == true ? '✅ Berhasil' : '❌ Gagal'),
          content: Text(data['message'] ?? 'Tidak ada respons dari server.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup popup
                // Jeda 2 detik sebelum kamera bisa dipakai lagi
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) setState(() => isProcessing = false);
                });
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error jaringan: $e')));
      setState(() => isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Tiket Jalan2kuy'),
        backgroundColor: const Color(0xFF16c4b0),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                verifyTicket(barcodes.first.rawValue!);
              }
            },
          ),
          // Garis bantu scan
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 4),
                borderRadius: BorderRadius.circular(12)
              ),
            ),
          ),
          if (isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 10),
                    Text("Memverifikasi Tiket...", style: TextStyle(color: Colors.white, fontSize: 16))
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}