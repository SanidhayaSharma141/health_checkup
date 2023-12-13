import 'package:alemeno_health_checkup/data/test_packages.dart';
import 'package:alemeno_health_checkup/model/functions.dart';
import 'package:alemeno_health_checkup/model/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'cart_screen.dart';
import 'data/health_test.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 816
          ? null
          : AppBar(
              title: const Text("Health Checkup"),
              actions: [
                IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CartPage())),
                    icon: const Icon(Icons.shopping_bag_outlined))
              ],
            ),
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        return SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (MediaQuery.of(context).size.width > 816)
                  Row(
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        size: 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Home",
                            style: TextStyle(color: Colors.blue),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "View Tests",
                            style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "About us",
                            style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Contact",
                            style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            label: Text("Cart"),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => CartPage())),
                            icon: Icon(Icons.shop_rounded),
                          ),
                        ),
                      )
                    ],
                  ),
                Text(
                  "Popular Tests",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
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
                        tests: snapshot.data!);
                  },
                ),
                const Divider(color: Colors.black),
                Text(
                  "Popular Packages",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
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
                        child: PackageTest(package: snapshot.data![0]));
                  },
                ),
              ]),
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class HealthTests extends StatefulWidget {
  HealthTests(
      {super.key, required this.sizingInformation, required this.tests});
  SizingInformation sizingInformation;
  List<Test> tests;

  @override
  State<HealthTests> createState() => _HealthTestsState();
}

class _HealthTestsState extends State<HealthTests> {
  bool isAdding = false;
  @override
  Widget build(BuildContext context) {
    widget.tests
        .sort((a, b) => b.numberOfTestsTaken.compareTo(a.numberOfTestsTaken));
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.sizingInformation.isDesktop ? 4 : 2,
          childAspectRatio: widget.sizingInformation.isDesktop ? 1.9 : 1.5),
      itemCount: widget.sizingInformation.isDesktop ? 8 : 4,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
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
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    widget.tests[index].testName,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Includes ${widget.tests[index].includesHowManyTests} tests",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 10),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 3),
                        decoration: BoxDecoration(
                          color: widget.tests[index].isSafe
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Icon(
                          widget.tests[index].isSafe
                              ? Icons.check_circle_outline
                              : Icons.cancel_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    "Get reports in 24 hours",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 10),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${widget.tests[index].priceInRupees}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '₹${widget.tests[index].discountPrice}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ButtonWidget(
                    isDesktop: widget.sizingInformation.isDesktop,
                    test: widget.tests[index])
              ],
            ),
          ),
        );
      },
    );
  }
}

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
