import 'package:alemeno_health_checkup/data/health_test.dart';
import 'package:alemeno_health_checkup/model/functions.dart';
import 'package:alemeno_health_checkup/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ValueNotifier<List<Test>> tests = ValueNotifier<List<Test>>([]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) => SingleChildScrollView(
          child: FutureBuilder(
            future: getCartData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Column(
                    children: [
                      Icon(Icons.hourglass_empty),
                      Text("Empty Cart"),
                    ],
                  ),
                );
              }
              tests.value = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Order Review",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.blue),
                    ),
                  ),
                  Card(
                    child: ResponsiveBuilder(
                      builder: (context, sizingInformation) =>
                          sizingInformation.isDesktop
                              ? _DesktopLayout(tests)
                              : _MobileLayout(tests),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatefulWidget {
  ValueNotifier<List<Test>> tests;

  _DesktopLayout(this.tests);

  @override
  State<_DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<_DesktopLayout> {
  bool isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Pathology Tests",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),
                if (isDeleting)
                  const Center(
                    child: Icon(Icons.update),
                  ),
                if (!isDeleting)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int index = 0;
                          index < widget.tests.value.length;
                          index++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.tests.value[index].testName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.blue),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '₹${widget.tests.value[index].discountPrice}/-',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '₹${widget.tests.value[index].priceInRupees}',
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Column(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    setState(() {
                                      isDeleting = !isDeleting;
                                    });
                                    final resp = await removeCart(
                                        test: widget.tests.value[index]);
                                    if (resp) {
                                      setState(() {
                                        widget.tests.value
                                            .remove(widget.tests.value[index]);
                                      });
                                    }
                                    setState(() {
                                      isDeleting = !isDeleting;
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  label: const Text("Remove"),
                                ),
                                SizedBox(height: 5),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.upload),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  label: const Text(
                                    "Upload prescription(optional)",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Add more"))
                    ],
                  ),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add more"))
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder(
              valueListenable: widget.tests,
              builder: (context, value, child) {
                return CartOrder(test: widget.tests);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatefulWidget {
  ValueNotifier<List<Test>> tests;

  _MobileLayout(this.tests);

  @override
  State<_MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<_MobileLayout> {
  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Pathology Tests",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              if (isDeleting)
                const Center(
                  child: Icon(Icons.update),
                ),
              if (!isDeleting)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int index = 0;
                        index < widget.tests.value.length;
                        index++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.tests.value[index].testName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.blue),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹${widget.tests.value[index].discountPrice}/-',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '₹${widget.tests.value[index].priceInRupees}',
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Column(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  setState(() {
                                    isDeleting = !isDeleting;
                                  });
                                  final resp = await removeCart(
                                      test: widget.tests.value[index]);
                                  if (resp) {
                                    setState(() {
                                      widget.tests.value
                                          .remove(widget.tests.value[index]);
                                    });
                                  }
                                  setState(() {
                                    isDeleting = !isDeleting;
                                  });
                                },
                                icon: const Icon(Icons.delete),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                label: const Text("Remove"),
                              ),
                              SizedBox(height: 5),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.upload),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                label: const Text(
                                  "Upload prescription(optional)",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add more"))
                  ],
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CartOrder(test: widget.tests),
        ),
      ],
    );
  }
}
