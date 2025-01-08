import 'package:flutter/material.dart';
import 'package:tubes/Home/ContactUs.dart';
import 'package:tubes/sreens/login.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // Background image is applied to the entire screen here
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/lapar.jpg'), // Your background image
              fit: BoxFit.cover,
              opacity: 0.15,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  const Column(
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://i.stack.imgur.com/l60Hf.png', // Your profile image URL
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Jhon Doe',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                  Column(
                    children: [
                      // Aligned 'General' text to the left
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'General',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const ListTile(
                          leading: Icon(Icons.lock),
                          title: Text('Change Password'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // More Section
                      Column(
                        children: [
                          // Aligned 'More' text to the left
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'More',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Contact Us
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text('Contact Us'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                // Navigasi ke halaman ContactUs
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ContactUs(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Logout Button
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              leading:
                                  const Icon(Icons.logout, color: Colors.red),
                              title: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                              onTap: () {
                                // Navigasi ke halaman login
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginPage()), // Ganti LoginPage dengan halaman login Anda
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
