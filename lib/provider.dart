import 'package:alemeno_health_checkup/data/health_test.dart';
import 'package:alemeno_health_checkup/data/test_packages.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final packageProvider =
    StateNotifierProvider<PackageList, List<HealthPackage>>((ref) {
  return PackageList();
}, name: 'packageProvider');

class PackageList extends StateNotifier<List<HealthPackage>> {
  PackageList() : super([]);
  void updatePackages(List<HealthPackage> newPackages) {
    state = newPackages;
  }
}

final testProvider = StateNotifierProvider<TestList, List<Test>>((ref) {
  return TestList();
}, name: 'testProvider');

class TestList extends StateNotifier<List<Test>> {
  TestList() : super([]);
  void updateTest(List<Test> newTest) {
    state = newTest;
  }
}

final cartProvider = StateNotifierProvider<CartList, List<Test>>((ref) {
  return CartList();
}, name: 'cartProvider');

class CartList extends StateNotifier<List<Test>> {
  CartList() : super([]);
  void updateCart(List<Test> newTest) {
    state = newTest;
  }

  void removeCart(Test? test, List<Test>? tests) {
    if (test == null) {
      for (final x in tests!) {
        state.remove(x);
      }
    } else {
      state.remove(test);
    }
  }
}
