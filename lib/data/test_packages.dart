import 'package:flutter/material.dart';

class HealthPackage {
  String title;
  int includesHowManyTests;
  List<dynamic> componentsTested;
  bool isSafe;
  double price;
  String category;
  bool isInCart;

  HealthPackage({
    required this.title,
    required this.includesHowManyTests,
    required this.componentsTested,
    required this.isSafe,
    required this.price,
    required this.category,
    required this.isInCart,
  });
}
