import 'package:flutter/material.dart';
import 'package:tugasaplikasi/chatPageDetail.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, String>> consultants = [
      {'name': 'Chef Anton', 'imagePath': 'assets/consultans/chef1.jpg'},
      {'name': 'Chef Bella', 'imagePath': 'assets/consultans/chef2.jpg'},
      {'name': 'Chef Carlo', 'imagePath': 'assets/consultans/chef3.jpg'},
      // Tambah sesuai kebutuhan
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.orange,
        title: Text(
          'Konsultasi Dengan Chef',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),

        actions: [
          Row(
            children: const [
              Tooltip(
                message: 'Notifikasi',
                child: Icon(Icons.notifications_none, color: Colors.white),
              ),
              SizedBox(width: 12),
              Tooltip(
                message: 'Cari resep',
                child: Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: consultants.length,
        itemBuilder: (context, index) {
          final consultant = consultants[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: screenWidth * 0.08,
                backgroundImage: AssetImage(consultant['imagePath']!),
                backgroundColor: Colors.grey[300],
              ),
              title: Text(
                consultant['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: const Text('Tersedia untuk konsultasi resep!'),
              trailing: const Icon(Icons.chat, color: Colors.orange),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ChatDetailPage(
                          chefName: consultant['name']!,
                          imagePath: consultant['imagePath']!,
                        ),
                  ),
                );
                // aksi ketika klik chat dengan chef
              },
            ),
          );
        },
      ),
    );
  }
}
