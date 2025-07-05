import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isDarkMode = false;
  bool isNotificationEnabled = true;
  bool isVibrationEnabled = false;

  String selectedLanguage = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: true,
        title: Text(
          'Pengaturan Akun',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Row(
            children: [
              Tooltip(
                message: 'Notifikasi',
                child: Icon(Icons.notifications_none, color: Colors.white),
              ),
              SizedBox(width: 12),
              Tooltip(
                message: 'Cari resep',
                child: Icon(Icons.search, color: Colors.white),
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildProfileCard(),
              const SizedBox(height: 24),
              _buildSettingsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/consultans/profile.jpg'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Kelompok PT.969',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'PT.969@mikroskil.students.ac.id',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pengaturan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Column(
            children: [
              _buildSwitchTile(
                title: 'Mode Gelap',
                subtitle: 'Aktifkan / Nonaktifkan dark mode',
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              const Divider(height: 1),
              _buildDropdownTile(),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Notifikasi',
                subtitle: 'Aktifkan / Nonaktifkan notifikasi',
                value: isNotificationEnabled,
                onChanged: (value) {
                  setState(() {
                    isNotificationEnabled = value;
                  });
                },
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Getar',
                subtitle: 'Aktifkan / Nonaktifkan getaran',
                value: isVibrationEnabled,
                onChanged: (value) {
                  setState(() {
                    isVibrationEnabled = value;
                  });
                },
              ),
              const Divider(height: 1),
              _buildSimpleTile(title: 'Ganti Password', icon: Icons.lock),
              const Divider(height: 1),
              _buildSimpleTile(
                title: 'Tentang Aplikasi',
                icon: Icons.info,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutAppPage(),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              _buildSimpleTile(
                title: 'Keluar',
                icon: Icons.logout,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: const Icon(Icons.toggle_on),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        activeColor: Colors.orange,
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownTile() {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('Bahasa'),
      trailing: DropdownButton<String>(
        value: selectedLanguage,
        underline: Container(),
        onChanged: (String? newValue) {
          setState(() {
            selectedLanguage = newValue!;
          });
        },
        items: <String>['Indonesia', 'English', 'Spanish', 'French']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }

  Widget _buildSimpleTile({
    required String title,
    required IconData icon,
    Color color = Colors.black87,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

// ======= Halaman Tentang Aplikasi =========

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Daily  Cooking',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            SizedBox(height: 8),
            Text('Versi: 1.0.0'),
            SizedBox(height: 16),
            Text(
              'Deskripsi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'ResepIn adalah aplikasi resep masakan yang membantu pengguna menemukan, menyimpan, dan mengikuti resep dengan mudah. Fitur-fitur seperti langkah memasak, bahan terstruktur, dan timer menjadikan pengalaman memasak lebih nyaman.',
            ),
            SizedBox(height: 16),
            Text(
              'Fitur Utama',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('• Telusuri ribuan resep dari berbagai kategori'),
            Text('• Simpan resep favorit ke bookmark'),
            Text('• Ikuti langkah memasak dengan timer'),
            Text('• Bagikan resep ke teman'),
            Text('• Mode gelap untuk kenyamanan mata'),
            SizedBox(height: 16),
            Text(
              'Kontak & Dukungan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('Email: PT.969@mikroskil.students.ac.id'),
            Text('Instagram: @MikhaelRaynara'),
            SizedBox(height: 16),
            Text(
              '© 2025 ResepIn. Dibuat oleh Kelompok PT.969 - Universitas Mikroskil.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}