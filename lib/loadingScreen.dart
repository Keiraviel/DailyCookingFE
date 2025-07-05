import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tugasaplikasi/homePage.dart'; // ganti sesuai path kamu

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          bookmarked: <int>{},
          onBookmarkChanged: (newBookmarks) {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/onboard/loading.json',
              width: size.width * 0.6,
              height: size.height * 0.6,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20), // Added SizedBox for spacing
            const Text(
              'Sedang menyiapkan aplikasi...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}