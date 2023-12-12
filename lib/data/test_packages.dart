import 'package:flutter/material.dart';

class HealthPackage {
  String title;
  int includesHowManyTests;
  List<String> componentsTested;
  bool isSafe;
  double price;
  IconData icon;
  String category;

  HealthPackage({
    required this.title,
    required this.includesHowManyTests,
    required this.componentsTested,
    required this.isSafe,
    required this.price,
    required this.icon,
    required this.category,
  });
}

List<HealthPackage> healthPackages = [
  HealthPackage(
    title: "Cardiac Wellness Package",
    includesHowManyTests: 5,
    componentsTested: [
      "ECG",
      "Troponin Levels",
      "Cholesterol Levels",
      "Blood Pressure",
      "Echocardiogram"
    ],
    isSafe: true,
    price: 2000,
    icon: Icons.favorite,
    category: "Heart",
  ),
  HealthPackage(
    title: "Comprehensive Senior Health Checkup",
    includesHowManyTests: 10,
    componentsTested: [
      "Bone Density",
      "Lipid Profile",
      "Kidney Function Tests",
      "Liver Function Tests",
      "Complete Blood Count",
      "ECG",
      "Urine Analysis",
      "Thyroid Function Tests",
      "Fasting Blood Sugar",
      "Blood Pressure"
    ],
    isSafe: true,
    price: 2500,
    icon: Icons.accessibility_new,
    category: "Elderly",
  ),
  HealthPackage(
    title: "Women's Wellness Package",
    includesHowManyTests: 8,
    componentsTested: [
      "Pap Smear",
      "Mammogram",
      "Complete Blood Count",
      "Thyroid Function Tests",
      "Bone Density",
      "Lipid Profile",
      "Blood Pressure",
      "Blood Sugar"
    ],
    isSafe: true,
    price: 1800,
    icon: Icons.pregnant_woman,
    category: "Women Health",
  ),
  HealthPackage(
    title: "Men's Health Screening",
    includesHowManyTests: 7,
    componentsTested: [
      "Prostate-Specific Antigen",
      "Testosterone Levels",
      "Lipid Profile",
      "Blood Pressure",
      "Complete Blood Count",
      "Urine Analysis",
      "Fasting Blood Sugar"
    ],
    isSafe: true,
    price: 1900,
    icon: Icons.accessible_forward,
    category: "Men",
  ),
  HealthPackage(
    title: "Diabetes Management Package",
    includesHowManyTests: 6,
    componentsTested: [
      "HbA1c",
      "Fasting Blood Sugar",
      "Insulin Levels",
      "Cholesterol Levels",
      "Kidney Function Tests",
      "Blood Pressure"
    ],
    isSafe: true,
    price: 1500,
    icon: Icons.favorite,
    category: "Diabetes",
  ),
  HealthPackage(
    title: "Heart Health Checkup",
    includesHowManyTests: 4,
    componentsTested: [
      "ECG",
      "Cholesterol Levels",
      "Blood Pressure",
      "Troponin Levels"
    ],
    isSafe: true,
    price: 1200,
    icon: Icons.favorite,
    category: "Heart",
  ),
  HealthPackage(
    title: "Senior Citizen Wellness Package",
    includesHowManyTests: 9,
    componentsTested: [
      "Bone Density",
      "Lipid Profile",
      "Kidney Function Tests",
      "Liver Function Tests",
      "Complete Blood Count",
      "ECG",
      "Urine Analysis",
      "Thyroid Function Tests",
      "Blood Pressure"
    ],
    isSafe: true,
    price: 2200,
    icon: Icons.accessibility_new,
    category: "Elderly",
  ),
  HealthPackage(
    title: "Women's Hormone Panel",
    includesHowManyTests: 5,
    componentsTested: [
      "Estrogen Levels",
      "Progesterone Levels",
      "LH",
      "FSH",
      "Thyroid Function Tests"
    ],
    isSafe: true,
    price: 1600,
    icon: Icons.pregnant_woman,
    category: "Women Health",
  ),
  HealthPackage(
    title: "Men's Hormone Panel",
    includesHowManyTests: 4,
    componentsTested: ["Testosterone Levels", "DHEA-S", "LH", "FSH"],
    isSafe: true,
    price: 1700,
    icon: Icons.accessible_forward,
    category: "Men",
  ),
  HealthPackage(
    title: "Blood Sugar Monitoring Package",
    includesHowManyTests: 3,
    componentsTested: [
      "Fasting Blood Sugar",
      "Postprandial Blood Sugar",
      "HbA1c"
    ],
    isSafe: true,
    price: 800,
    icon: Icons.favorite,
    category: "Diabetes",
  ),
];
