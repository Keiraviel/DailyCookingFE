import 'package:flutter/widgets.dart';

class MasakanCategory {
  final String name;
  bool isSelected;

  MasakanCategory({
    required this.name,
    this.isSelected = false,
  });
}

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'Indonesia';

  bool get isDarkMode => _isDarkMode;
  String get language => _language;

  void toggleDarkMode(bool isOn) {
    _isDarkMode = isOn;
    notifyListeners();
  }

  void changeLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }
}

class Consultant {
  final String name;
  final String role;
  final String imagePath;

  Consultant({
    required this.name,
    required this.role,
    required this.imagePath,
  });
}
