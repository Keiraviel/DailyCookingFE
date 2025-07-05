import 'package:flutter/material.dart';
import 'package:tugasaplikasi/provider.dart';

class ConsultantProvider with ChangeNotifier {
  final List<Consultant> _consultants = [
    Consultant(
      name: 'Chef Gordon',
      role: 'Head Chef',
      imagePath: 'assets/consultans/chef1.jpg',
    ),
    Consultant(
      name: 'Chef Amelia',
      role: 'Pastry Chef',
      imagePath: 'assets/consultans/chef2.jpg',
    ),
    Consultant(
      name: 'Chef Marco',
      role: 'Sous Chef',
      imagePath: 'assets/consultans/chef3.jpg',
    ),
    // Consultant(
    //   name: 'Chef Hana',
    //   role: 'Culinary Expert',
    //   imagePath: 'assets/consultans/chef4.jpg',
    // ),
  ];

  List<Consultant> get consultants => _consultants;
}
