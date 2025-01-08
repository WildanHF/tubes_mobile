import 'package:flutter/material.dart';

class Historypage extends StatelessWidget {
  const Historypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                NotificationItem(
                  icon: Icons.attach_money_outlined,
                  title: 'Donate to Isha Foundation',
                  subtitle: '08 Nov 2023 • 9:40 PM',
                  amount: 'Rp. 50.000',
                ),
                NotificationItem(
                  icon: Icons.attach_money_outlined,
                  title: 'Donate to Isha Foundation',
                  subtitle: '06 Nov 2023 • 2:09 PM',
                  amount: 'Rp. 75.000',
                ),
                NotificationItem(
                  icon: Icons.attach_money_outlined,
                  title: 'Donate to Isha Foundation',
                  subtitle: '04 Nov 2023 • 1:09 PM',
                  amount: 'Rp. 150.000',
                ),
                NotificationItem(
                  icon: Icons.attach_money_outlined,
                  title: 'Donate to Isha Foundation',
                  subtitle: '01 Nov 2023 • 12:09 PM',
                  amount: 'Rp. 50.000',
                ),
                NotificationItem(
                  icon: Icons.fastfood,
                  title: 'Donate to Isha Foundation',
                  subtitle: '01 Nov 2023 • 12:09 PM',
                  amount: '5 Kg',
                ),
                NotificationItem(
                  icon: Icons.fastfood,
                  title: 'Donate to Isha Foundation',
                  subtitle: '01 Nov 2023 • 12:09 PM',
                  amount: '1 Kg',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}
