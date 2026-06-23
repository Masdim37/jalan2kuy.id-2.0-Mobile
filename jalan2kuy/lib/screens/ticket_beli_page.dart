import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import 'payment_webview.dart';
import 'MyTicketPage.dart';

class TicketBeliPage extends StatefulWidget {
  final String eventID;
  const TicketBeliPage({Key? key, required this.eventID}) : super(key: key);

  @override
  State<TicketBeliPage> createState() => _TicketBeliPageState();
}

class _TicketBeliPageState extends State<TicketBeliPage> {
  int qty = 1;
  bool isLoading = false;

  Future<void> checkout() async {
    setState(() => isLoading = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.eventBeliTiket}/${widget.eventID}'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
        body: {'qty': qty.toString()},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        // Buka Midtrans WebView
        bool? isSuccess = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PaymentWebview(url: data['redirect_url'])),
        );
        // Arahkan ke MyTicket apapun hasilnya (karena callback Laravel akan memproses statusnya di background)
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const MyTicketPage()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'] ?? 'Gagal checkout')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Tiket')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Jumlah Tiket:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () { if (qty > 1) setState(() => qty--); }, icon: const Icon(Icons.remove_circle, size: 30)),
                Text('$qty', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () => setState(() => qty++), icon: const Icon(Icons.add_circle, size: 30, color: Color(0xFF16c4b0))),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : checkout,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF16c4b0)),
                child: isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text("Lanjut ke Pembayaran", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}