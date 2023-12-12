import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'data/health_test.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Sort the tests based on numTestTaken attribute in descending order
    tests.sort((a, b) => b.numberOfTestsTaken.compareTo(a.numberOfTestsTaken));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Checkup"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.badge))],
      ),
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        return SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Popular Tests",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                HealthTests(sizingInformation: sizingInformation),
                Divider(color: Colors.black),
                Text(
                  "Popular Packages",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                HealthTests(sizingInformation: sizingInformation),
              ]),
        );
      }),
    );
  }
}

class HealthTests extends StatefulWidget {
  HealthTests({super.key, required this.sizingInformation});
  SizingInformation sizingInformation;

  @override
  State<HealthTests> createState() => _HeathTestsState();
}

class _HeathTestsState extends State<HealthTests> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.sizingInformation.isDesktop ? 4 : 2,
          childAspectRatio: widget.sizingInformation.isDesktop ? 1.8 : 1.2),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
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
                  tests[index].testName,
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
                        "Includes ${tests[index].includesHowManyTests} tests",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 3),
                      decoration: BoxDecoration(
                        color: tests[index].isSafe
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Icon(
                        tests[index].isSafe
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
              // if(sizingInformation.isDesktop)

              Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${tests[index].priceInRupees}',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.red,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '₹${tests[index].discountPrice}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        child: Text(
                          "Add to Cart",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        child: Text(
                          "View Details",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
