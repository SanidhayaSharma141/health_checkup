import 'package:alemeno_health_checkup/all_packages.dart';
import 'package:alemeno_health_checkup/all_tests.dart';
import 'package:alemeno_health_checkup/cart_screen.dart';
import 'package:alemeno_health_checkup/data/health_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:alemeno_health_checkup/data/test_packages.dart';
import 'package:alemeno_health_checkup/model/functions.dart';
import 'package:alemeno_health_checkup/model/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 816
          ? null
          : AppBar(
              title: const Text("Health Checkup"),
              actions: [
                IconButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CartPage()));
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                )
              ],
            ),
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (MediaQuery.of(context).size.width > 816) DesktopNavigation(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Tests",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                      onPressed: () async {
                        await Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => TestsView()));
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Text("View More")),
                ],
              ),
              FutureBuilder(
                future: getTests(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return HealthTests(
                    sizingInformation: sizingInformation,
                    tests: snapshot.data!,
                  );
                },
              ),
              const Divider(color: Colors.black),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Packages",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                      onPressed: () async {
                        await Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => PackagesView()));
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Text("View More")),
                ],
              ),
              FutureBuilder(
                future: getPackages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text("Empty Data"),
                    );
                  }
                  return Center(
                    child: PackageTest(package: snapshot.data![0]),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class DesktopNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.health_and_safety,
          size: 50,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 20),
        NavItem(title: 'Home', onPressed: () {}),
        NavItem(title: 'View Tests', onPressed: () {}),
        NavItem(title: 'About Us', onPressed: () {}),
        NavItem(title: 'Contact', onPressed: () {}),
        const Spacer(),
        ElevatedButton.icon(
          label: const Text("Cart"),
          onPressed: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const CartPage()));
            if (context.mounted) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
            }
          },
          icon: const Icon(Icons.shop_rounded),
        ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const NavItem({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.headlineSmall!.color,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HealthTests extends StatefulWidget {
  HealthTests({
    Key? key,
    required this.sizingInformation,
    required this.tests,
  }) : super(key: key);

  final SizingInformation sizingInformation;
  final List<Test> tests;

  @override
  State<HealthTests> createState() => _HealthTestsState();
}

class _HealthTestsState extends State<HealthTests> {
  bool isAdding = false;
  Tuple3<int, double, int> calculateGridParameters(double availableWidth) {
    int crossAxisCount = 2;
    double childAspectRatio = 1.1;
    int itemCount = 4;

    if (availableWidth > 816) {
      crossAxisCount = 4;
      childAspectRatio = 1.6;
      itemCount = 8;
    } else if (availableWidth > 600) {
      crossAxisCount = 3;
      childAspectRatio = 1.3;
      itemCount = 6;
    }

    return Tuple3<int, double, int>(
        crossAxisCount, childAspectRatio, itemCount);
  }

  @override
  Widget build(BuildContext context) {
    widget.tests
        .sort((a, b) => b.numberOfTestsTaken.compareTo(a.numberOfTestsTaken));

    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;

        Tuple3<int, double, int> gridParameters =
            calculateGridParameters(availableWidth);
        return GridView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridParameters.item1,
            childAspectRatio: gridParameters.item2,
          ),
          itemCount: gridParameters.item3,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: healthTestTile(
                  widget.tests[index], context, widget.sizingInformation),
            );
          },
        );
      },
    );
  }
}

Widget healthTestTile(Test test, BuildContext context,
        SizingInformation? sizingInformation) =>
    Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Text(
                test.testName,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Includes ${test.includesHowManyTests} tests",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: test.isSafe ? Colors.greenAccent : Colors.redAccent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Icon(
                    test.isSafe
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Get reports in 24 hours",
              style: Theme.of(context).textTheme.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${test.priceInRupees}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '₹${test.discountPrice}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ButtonWidget(
              isDesktop:
                  sizingInformation != null && sizingInformation.isDesktop,
              test: test,
            ),
          ],
        ),
      ),
    );

class PackageTest extends StatelessWidget {
  PackageTest({Key? key, required this.package}) : super(key: key);
  final HealthPackage package;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width > 816
          ? 400
          : MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.health_and_safety,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    package.isSafe ? Icons.check_circle : Icons.cancel,
                    color: package.isSafe ? Colors.green : Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Includes ${package.includesHowManyTests} tests",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹${package.price}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              CartPackageButton(
                test: package,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CartPackageButton extends StatefulWidget {
  CartPackageButton({super.key, required this.test});
  HealthPackage test;
  @override
  State<CartPackageButton> createState() => _CartPackageButtonState();
}

class _CartPackageButtonState extends State<CartPackageButton> {
  bool isAdding = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!widget.test.isInCart) {
          setState(() {
            isAdding = !isAdding;
          });
          try {
            await FirebaseFirestore.instance
                .collection('Cart')
                .doc(widget.test.title)
                .set({"test": false});
          } catch (e) {
            setState(() {
              isAdding = !isAdding;
            });
            return;
          }

          setState(() {
            widget.test.isInCart = true;
            isAdding = !isAdding;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isAdding
            ? Colors.orange
            : widget.test.isInCart
                ? Colors.green
                : Theme.of(context).primaryColor,
      ),
      child: Text(
        isAdding
            ? "Adding to Cart"
            : widget.test.isInCart
                ? "Added to Cart"
                : "Add to Cart",
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
