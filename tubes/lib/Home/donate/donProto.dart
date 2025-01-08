import 'package:flutter/material.dart';
import 'package:tubes/Home/Homepage.dart';
// import 'package:tubes/Home/donate/payments.dart'; // Import halaman PaymentPage
import 'package:http/http.dart' as http;
import 'dart:convert';

class Donproto extends StatelessWidget {
  final String name;
  final String description;

  const Donproto({Key? key, required this.name, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _donationController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 245, 107),
                Color.fromARGB(255, 247, 247, 247),
              ],
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      backBtn(),
                      SizedBox(height: 20),
                      Container(
                        width: 400,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _donationController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Masukkan Nominal Donasi',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validasi input
                                  if (_donationController.text.isNotEmpty &&
                                      double.tryParse(_donationController.text) != null) {
                                    // Navigasi ke PaymentPage
                                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PaymentPage(
      campaignId: "some_campaign_id", // You can replace with actual campaign ID
      campaignName: name,
      donationAmount: _donationController.text,
    ),
  ),
);
                                  } else {
                                    // Menampilkan pesan error
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Masukkan nominal yang valid!')),
                                    );
                                  }
                                },
                                child: Text('Donate'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 236, 243, 33),
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class backBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
          );
        },
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final String campaignName;
  final String donationAmount;

  const PaymentPage({
    Key? key,
    required this.campaignName,
    required this.donationAmount, 
    required String campaignId,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String paymentStatus = "NOT PAID";

  Future<void> makePayment() async {
    const String apiUrl = "http://192.168.100.42:3000/api/payments";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "campaign_name": widget.campaignName,
          "donation_amount": widget.donationAmount,
          "status": "PAID", // Payment status set as PAID
          "created_at": DateTime.now().toIso8601String(), // Timestamp for created_at
          "updated_at": DateTime.now().toIso8601String(), // Timestamp for updated_at
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        if (mounted) {
          setState(() {
            paymentStatus = "PAID";
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Payment successful!")),
          );

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to process payment.")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error during payment.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Details"),
        backgroundColor: const Color(0xFFFCE905),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Campaign",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.campaignName,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nominal",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.donationAmount,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Payment status",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: paymentStatus == "PAID"
                                ? Colors.green
                                : Colors.orange,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            paymentStatus,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: makePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Pay",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
