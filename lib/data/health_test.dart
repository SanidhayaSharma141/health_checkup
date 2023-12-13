class Test {
  String testName;
  int includesHowManyTests;
  bool isSafe;
  List<dynamic> componentsToBeTested;
  double priceInRupees;
  double discountPrice;
  String category;
  int numberOfTestsTaken;
  bool isInCart;

  Test({
    required this.testName,
    required this.includesHowManyTests,
    required this.isSafe,
    required this.componentsToBeTested,
    required this.priceInRupees,
    required this.discountPrice,
    required this.category,
    required this.numberOfTestsTaken,
    required this.isInCart,
  });
}
