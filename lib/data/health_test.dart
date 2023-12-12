class Test {
  String testName;
  int includesHowManyTests;
  bool isSafe;
  List<String> componentsToBeTested;
  double priceInRupees;
  double discountPrice;
  String category;
  int numberOfTestsTaken;

  Test({
    required this.testName,
    required this.includesHowManyTests,
    required this.isSafe,
    required this.componentsToBeTested,
    required this.priceInRupees,
    required this.discountPrice,
    required this.category,
    required this.numberOfTestsTaken,
  });
}

//Haven't used Firebase, could have used firebase too
List<Test> tests = [
  Test(
    testName: "Basic Health Checkup",
    includesHowManyTests: 5,
    isSafe: true,
    componentsToBeTested: [
      "Blood Pressure",
      "Blood Sugar",
      "Cholesterol",
      "Complete Blood Count",
      "Urine Analysis"
    ],
    priceInRupees: 1500,
    discountPrice: 1200,
    category: "Basic",
    numberOfTestsTaken: 137,
  ),
  Test(
    testName: "Diabetes Panel",
    includesHowManyTests: 3,
    isSafe: false,
    componentsToBeTested: ["Fasting Blood Sugar", "HbA1c", "Insulin Levels"],
    priceInRupees: 800,
    discountPrice: 700,
    category: "Heart",
    numberOfTestsTaken: 65,
  ),
  Test(
    testName: "Full Body Checkup",
    includesHowManyTests: 10,
    isSafe: true,
    componentsToBeTested: [
      "CBC",
      "Lipid Profile",
      "Liver Function Tests",
      "Thyroid Function Tests",
      "Kidney Function Tests"
    ],
    priceInRupees: 2500,
    discountPrice: 2000,
    category: "Basic",
    numberOfTestsTaken: 17,
  ),
  Test(
    testName: "Cardiac Risk Assessment",
    includesHowManyTests: 4,
    isSafe: true,
    componentsToBeTested: [
      "ECG",
      "Cholesterol Levels",
      "Blood Pressure",
      "Troponin Levels"
    ],
    priceInRupees: 1200,
    discountPrice: 1000,
    category: "Heart",
    numberOfTestsTaken: 89,
  ),
  Test(
    testName: "Iron Deficiency Panel",
    includesHowManyTests: 2,
    isSafe: true,
    componentsToBeTested: ["Ferritin Levels", "Complete Blood Count"],
    priceInRupees: 600,
    discountPrice: 500,
    category: "Basic",
    numberOfTestsTaken: 65,
  ),
  Test(
    testName: "Thyroid Function Test",
    includesHowManyTests: 3,
    isSafe: true,
    componentsToBeTested: ["T3 Triiodothyronine", "T4 Thyroxine", "TSH"],
    priceInRupees: 700,
    discountPrice: 600,
    category: "Basic",
    numberOfTestsTaken: 102,
  ),
  Test(
    testName: "Vitamin D and B12 Panel",
    includesHowManyTests: 2,
    isSafe: true,
    componentsToBeTested: ["Vitamin D Levels", "Vitamin B12 Levels"],
    priceInRupees: 500,
    discountPrice: 450,
    category: "Basic",
    numberOfTestsTaken: 6,
  ),
  Test(
    testName: "Pregnancy Wellness Package",
    includesHowManyTests: 6,
    isSafe: true,
    componentsToBeTested: [
      "HCG Levels",
      "Blood Grouping",
      "Complete Blood Count",
      "Thyroid Function Tests",
      "Glucometer",
      "Urine Analysis"
    ],
    priceInRupees: 1800,
    discountPrice: 1500,
    category: "Basic",
    numberOfTestsTaken: 39,
  ),
  Test(
    testName: "Senior Citizen Health Checkup",
    includesHowManyTests: 8,
    isSafe: true,
    componentsToBeTested: [
      "Bone Density",
      "Lipid Profile",
      "Kidney Function Tests",
      "Liver Function Tests",
      "Complete Blood Count",
      "ECG",
      "Urine Analysis",
      "Thyroid Function Tests"
    ],
    priceInRupees: 2200,
    discountPrice: 1900,
    category: "Basic",
    numberOfTestsTaken: 27,
  ),
  Test(
    testName: "Allergy Screening",
    includesHowManyTests: 3,
    isSafe: true,
    componentsToBeTested: [
      "IgE Levels",
      "Skin Prick Test",
      "Blood Test for Specific Allergens"
    ],
    priceInRupees: 900,
    discountPrice: 800,
    category: "Mental",
    numberOfTestsTaken: 12,
  ),
  Test(
    testName: "Lung Function Test",
    includesHowManyTests: 2,
    isSafe: true,
    componentsToBeTested: ["Spirometry", "Peak Flow Measurement"],
    priceInRupees: 400,
    discountPrice: 350,
    category: "Fitness",
    numberOfTestsTaken: 56,
  ),
  Test(
    testName: "Genetic Predisposition Analysis",
    includesHowManyTests: 1,
    isSafe: true,
    componentsToBeTested: ["DNA Analysis"],
    priceInRupees: 1200,
    discountPrice: 1000,
    category: "Mental",
    numberOfTestsTaken: 23,
  ),
  Test(
    testName: "Metabolic Syndrome Panel",
    includesHowManyTests: 5,
    isSafe: true,
    componentsToBeTested: [
      "Blood Pressure",
      "Waist Circumference",
      "Blood Sugar",
      "Triglycerides",
      "HDL Cholesterol"
    ],
    priceInRupees: 1000,
    discountPrice: 850,
    category: "Heart",
    numberOfTestsTaken: 34,
  ),
  Test(
    testName: "Osteoporosis Screening",
    includesHowManyTests: 2,
    isSafe: true,
    componentsToBeTested: ["Bone Density", "Calcium Levels"],
    priceInRupees: 600,
    discountPrice: 500,
    category: "Fitness",
    numberOfTestsTaken: 20,
  ),
  Test(
    testName: "Food Sensitivity Test",
    includesHowManyTests: 3,
    isSafe: true,
    componentsToBeTested: [
      "IgG Levels for Common Allergens",
      "Blood Test for Specific Food Sensitivities",
      "Elimination Diet Guidance"
    ],
    priceInRupees: 800,
    discountPrice: 700,
    category: "Basic",
    numberOfTestsTaken: 67,
  ),
  Test(
    testName: "Male Hormone Panel",
    includesHowManyTests: 4,
    isSafe: true,
    componentsToBeTested: ["Testosterone Levels", "DHEA-S", "LH", "FSH"],
    priceInRupees: 900,
    discountPrice: 800,
    category: "Fitness",
    numberOfTestsTaken: 27,
  ),
  Test(
    testName: "Female Hormone Panel",
    includesHowManyTests: 4,
    isSafe: true,
    componentsToBeTested: [
      "Estrogen Levels",
      "Progesterone Levels",
      "LH",
      "FSH"
    ],
    priceInRupees: 950,
    discountPrice: 850,
    category: "Fitness",
    numberOfTestsTaken: 22,
  ),
  Test(
    testName: "Digestive Health Panel",
    includesHowManyTests: 3,
    isSafe: true,
    componentsToBeTested: [
      "Stool Analysis",
      "H. pylori Test",
      "Digestive Enzyme Levels"
    ],
    priceInRupees: 750,
    discountPrice: 650,
    category: "Basic",
    numberOfTestsTaken: 5,
  ),
  Test(
    testName: "Brain Health Assessment",
    includesHowManyTests: 3,
    isSafe: true,
    componentsToBeTested: [
      "Cognitive Function Test",
      "Neurotransmitter Levels",
      "MRI Brain Scan"
    ],
    priceInRupees: 1500,
    discountPrice: 1300,
    category: "Mental",
    numberOfTestsTaken: 76,
  ),
  Test(
    testName: "Sleep Apnea Screening",
    includesHowManyTests: 2,
    isSafe: true,
    componentsToBeTested: ["Polysomnography", "Epworth Sleepiness Scale"],
    priceInRupees: 1100,
    discountPrice: 950,
    category: "Fitness",
    numberOfTestsTaken: 43,
  ),
];
