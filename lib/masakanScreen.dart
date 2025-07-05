import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasaplikasi/loadingScreen.dart';
import 'package:tugasaplikasi/saranMasakan.dart';

class MasakanScreen extends StatefulWidget {
  const MasakanScreen({super.key});

  @override
  State<MasakanScreen> createState() => _MasakanScreenState();
}

class _MasakanScreenState extends State<MasakanScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MasakanProvider>(context);
    final categories = provider.categories;

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF59330),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        title: Text(
          'Apa yang sedang Anda ingin masak?',
          style: TextStyle(
            color: Colors.black,
            fontSize: width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: Text(
                    'Pilih 1 atau lebih untuk mengurasi pengalaman Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
                Wrap(
                  spacing: width * 0.03,
                  runSpacing: width * 0.03,
                  children: List.generate(categories.length, (index) {
                    final item = categories[index];
                    return AnimatedScale(
                      scale: item.isSelected ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: FilterChip(
                        label: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        selected: item.isSelected,
                        onSelected: (_) => provider.toggleSelection(index),
                        backgroundColor: const Color(0xFFFFFCF9),
                        selectedColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color:
                                item.isSelected
                                    ? Colors.deepOrange
                                    : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        elevation: item.isSelected ? 4 : 0,
                        shadowColor: Colors.black38,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.015,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: SizedBox(
          height: height * 0.07,
          child: ElevatedButton(
            onPressed: isLoading ? null : _handleNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFDFDFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
            ),
            child:
                isLoading
                    ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.deepOrange,
                      ),
                    )
                    : Text(
                      'Berikutnya',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.045,
                      ),
                    ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleNext() async {
    setState(() {
      isLoading = true;
    });

    // TUNGGU loading dulu (2 detik), jangan pakai push
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Setelah loading, langsung ganti halaman
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => LoadingScreen(
              //   bookmarked: <int>{},
              //   onBookmarkChanged: (newBookmarks) {
              //     print('Bookmark diperbarui: $newBookmarks');
              //   },
            ),
      ),
    );

    setState(() {
      isLoading = false;
    });
  }
}
