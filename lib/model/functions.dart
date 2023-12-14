import 'package:alemeno_health_checkup/data/health_test.dart';
import 'package:alemeno_health_checkup/data/test_packages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> enterData() async {
//   print("hi");
//   tests.forEach((element) async {
//     await FirebaseFirestore.instance
//         .collection('Tests')
//         .doc(element.testName)
//         .set({
//       "category": element.category,
//       "componentsToBeTested": element.componentsToBeTested,
//       "numberOfTestsTaken": element.numberOfTestsTaken,
//       "discountPrice": element.discountPrice,
//       "priceInRupees": element.priceInRupees,
//       "includesHowManyTests": element.includesHowManyTests,
//       "isSafe": element.isSafe
//     });
//   });
// }

// Future<void> enterPackageData() async {
//   print("hi");
//   healthPackages.forEach((element) async {
//     await FirebaseFirestore.instance
//         .collection('Packages')
//         .doc(element.title)
//         .set({
//       "category": element.category,
//       "componentsTested": element.componentsTested,
//       "price": element.price,
//       "includesHowManyTests": element.includesHowManyTests,
//       "isSafe": element.isSafe
//     });
//   });
// }

Future<void> addToCart(String testName) async {
  await FirebaseFirestore.instance
      .collection('Cart')
      .doc(testName)
      .set({"testName": testName});
}

Future<List<Test>> getTests() async {
  List<Test> list = [];
  final resp = await FirebaseFirestore.instance
      .collection('Tests')
      .get(const GetOptions(source: Source.serverAndCache));
  final resp2 = await FirebaseFirestore.instance
      .collection('Cart')
      .get(const GetOptions(source: Source.serverAndCache));
  List<String> cartIds = resp2.docs.map((e) => e.id).toList();
  for (final doc in resp.docs) {
    bool isInCart = false;
    if (cartIds.contains(doc.id)) {
      isInCart = true;
    }
    final category = doc['category'].toString();
    final componentsToBeTested = doc['componentsToBeTested'].toList();
    final discountPrice = doc['discountPrice'].toDouble();
    final includesHowManyTests = doc['includesHowManyTests'].toInt();
    final isSafe = doc['isSafe'];
    final numberOfTestsTaken = doc['numberOfTestsTaken'].toInt();

    final priceInRupees = doc['priceInRupees'].toDouble();

    final testName = doc.id;
    Test x = Test(
      category: category.toString(),
      componentsToBeTested: componentsToBeTested,
      discountPrice: discountPrice,
      includesHowManyTests: includesHowManyTests,
      isSafe: isSafe,
      numberOfTestsTaken: numberOfTestsTaken,
      priceInRupees: priceInRupees,
      testName: testName,
      isInCart: isInCart,
    );

    list.add(x);
  }
  list.sort((a, b) => b.numberOfTestsTaken.compareTo(a.numberOfTestsTaken));
  return list;
}

Future<List<HealthPackage>> getPackages() async {
  List<HealthPackage> list = [];
  final resp = await FirebaseFirestore.instance
      .collection('Packages')
      .get(const GetOptions(source: Source.serverAndCache));
  final resp2 = await FirebaseFirestore.instance
      .collection('Cart')
      .get(const GetOptions(source: Source.serverAndCache));
  List<String> cartIds = resp2.docs.map((e) => e.id).toList();
  for (final doc in resp.docs) {
    bool isInCart = false;
    if (cartIds.contains(doc.id)) {
      isInCart = true;
    }
    final category = doc['category'];
    final componentsTested = doc['componentsTested'].toList();
    final price = doc['price'];
    final includesHowManyTests = doc['includesHowManyTests'];
    final isSafe = doc['isSafe'];
    final title = doc.id;
    print(title);
    list.add(HealthPackage(
        category: category.toString(),
        componentsTested: componentsTested,
        price: price.toDouble(),
        includesHowManyTests: includesHowManyTests,
        isSafe: isSafe,
        isInCart: isInCart,
        title: title.toString()));
    print(list);
  }
  return list;
}

Future<List<Test>> getCartData() async {
  List<Test> list = [];
  final resp = await FirebaseFirestore.instance
      .collection('Cart')
      .get(GetOptions(source: Source.serverAndCache));
  List<String> cartIds = resp.docs.map((e) => e.id).toList();
  final xData = await FirebaseFirestore.instance
      .collection('Tests')
      .where(FieldPath.documentId, whereIn: cartIds)
      .get(GetOptions(source: Source.serverAndCache));

  final yData = await FirebaseFirestore.instance
      .collection('Packages')
      .where(FieldPath.documentId, whereIn: cartIds)
      .get(GetOptions(source: Source.serverAndCache));
  for (final doc in xData.docs) {
    final category = doc['category'].toString();
    final componentsToBeTested = doc['componentsToBeTested'].toList();
    final discountPrice = doc['discountPrice'].toDouble();
    final includesHowManyTests = doc['includesHowManyTests'].toInt();
    final isSafe = doc['isSafe'];
    final numberOfTestsTaken = doc['numberOfTestsTaken'].toInt();

    final priceInRupees = doc['priceInRupees'].toDouble();

    final testName = doc.id;
    print("hi");
    Test x = Test(
      category: category.toString(),
      componentsToBeTested: componentsToBeTested,
      discountPrice: discountPrice,
      includesHowManyTests: includesHowManyTests,
      isSafe: isSafe,
      numberOfTestsTaken: numberOfTestsTaken,
      priceInRupees: priceInRupees,
      testName: testName,
      isInCart: true,
    );

    print(x);
    list.add(x);
  }
  for (final doc in yData.docs) {
    final category = doc['category'].toString();
    final componentsToBeTested = doc['componentsTested'].toList();
    final discountPrice = doc['price'].toDouble();
    final includesHowManyTests = doc['includesHowManyTests'].toInt();
    final isSafe = doc['isSafe'];
    final numberOfTestsTaken = 0;

    final priceInRupees = discountPrice + 1000;

    final testName = doc.id;
    Test x = Test(
      category: category,
      componentsToBeTested: componentsToBeTested,
      discountPrice: discountPrice,
      includesHowManyTests: includesHowManyTests,
      isSafe: isSafe,
      numberOfTestsTaken: numberOfTestsTaken,
      priceInRupees: priceInRupees,
      testName: testName,
      isInCart: true,
    );

    print(x);
    list.add(x);
  }
  return list;
}

Future<bool> removeCart({Test? test, List<Test>? testList}) async {
  try {
    if (test != null) {
      await FirebaseFirestore.instance
          .collection('Cart')
          .doc(test.testName)
          .delete();
      return true;
    }
    for (final x in testList!) {
      await FirebaseFirestore.instance
          .collection('Cart')
          .doc(x.testName)
          .delete();
    }
    return true;
  } catch (e) {
    return false;
  }
}
