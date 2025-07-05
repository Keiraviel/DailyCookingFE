import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tugasaplikasi/SignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Ambil ukuran layar
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingPage(
                  title: "Temukan Resep Makanan Favorit Anda",
                  description: "Nikmati cita rasa istimewa dari mahakarya kuliner kami – Berbagai resep yang disediakan, disajikan di atas hamparan yang dibumbui dengan sempurna, dan dicampur dengan sayuran yang sesuai dengan anda.",
                  imagePath: 'assets/onboard/Sayur.png',
                  width: width,
                  height: height,
                ),
                OnboardingPage(
                  title: "Inspirasi Resep Lezat untuk Anda",
                  description: "Temukan ide-ide resep lezat yang mudah dibuat dan cocok untuk segala kesempatan.",
                  imagePath: 'assets/onboard/ayampanggang.png',
                  width: width,
                  height: height,
                ),
                OnboardingPage(
                  title: "Inspirasi Memasak dengan Resep Pilihan",
                  description: "Temukan berbagai resep pilihan untuk memudahkan Anda memasak.",
                  imagePath: 'assets/onboard/ayam.png',
                  width: width,
                  height: height,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02, 
              horizontal: width * 0.05
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage > 0
                    ? ElevatedButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Text("Back", style: TextStyle(color: Colors.black, fontSize: width * 0.045)),
                      )
                    : SizedBox(width: width * 0.2),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Color.fromARGB(255, 220, 95, 11),
                    dotHeight: height * 0.01,
                    dotWidth: width * 0.025,
                  ),
                ),
                _currentPage < 2
                    ? ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Text("Next", style: TextStyle(color: Colors.black, fontSize: width * 0.045)),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Text("Mulai", style: TextStyle(color: Colors.black, fontSize: width * 0.045)),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double width;
  final double height;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: height * 0.35, // gambar 35% dari tinggi layar
          ),
          SizedBox(height: height * 0.04),
          Text(
            title,
            style: TextStyle(
              fontSize: width * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.02),
          Text(
            description,
            style: TextStyle(
              fontSize: width * 0.04,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
