import 'package:flutter/material.dart';
import 'package:tugasaplikasi/provider.dart';


class MasakanProvider with ChangeNotifier {
  final List<MasakanCategory> _categories = [
    MasakanCategory(name: 'Makanan Tradisional'),
    MasakanCategory(name: 'Cepat Saji' ),
    MasakanCategory(name: 'Kue & Dessert' ),
    MasakanCategory(name: 'Minuman' ),
    MasakanCategory(name: 'Makanan Sehat' ),
    MasakanCategory(name: 'Masakan Rumahan' ),
    MasakanCategory(name: 'protein' ),
    MasakanCategory(name: 'karbohidrat' ),
    MasakanCategory(name: 'Lemak', ),
    MasakanCategory(name: 'Serat', ),
    MasakanCategory(name: 'Vitamin', ),
    MasakanCategory(name: 'hewani', ),
    MasakanCategory(name: 'pokok',),
    MasakanCategory(name: 'hewani'),
    MasakanCategory(name: 'Protein Nabati',),
    MasakanCategory(name: 'Zat Besi'),
  ];

  List<MasakanCategory> get categories => _categories;

  void toggleSelection(int index) {
    _categories[index].isSelected = !_categories[index].isSelected;
    notifyListeners();
  }
}
