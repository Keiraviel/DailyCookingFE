import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasaplikasi/ChatProvider.dart';
import 'package:tugasaplikasi/provider.dart';
import 'package:tugasaplikasi/SplashScreen.dart';
import 'package:tugasaplikasi/saranMasakan.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MasakanProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => ConsultantProvider()), // Tambahkan ini
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: settings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SplashScreen(), // SplashScreen Anda tetap
    );
  }
}
