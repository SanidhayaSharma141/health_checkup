import 'package:flutter/material.dart';
import 'data/health_test.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool value = false;
  List<Test> test = tests;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Order Review",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.blue),
            ),
            Card(
                child: MediaQuery.of(context).size.width > 816
                    ? Row()
                    : Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Pathology Tests",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            test[index].testName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(color: Colors.blue),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  '₹${test[index].discountPrice}/-',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  '₹${test[index].priceInRupees}',
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.red,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete),
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)))),
                                          label: const Text("Remove")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(Icons.upload),
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)))),
                                          label: const Text(
                                            "Upload prescription(optional)",
                                            overflow: TextOverflow.clip,
                                          )),
                                      const Divider()
                                    ],
                                  );
                                },
                                itemCount: 2,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                          Column(
                            children: [
                              Card(
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month),
                                    Expanded(
                                        child: TextButton(
                                            style: ButtonStyle(
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: Colors.grey))),
                                            onPressed: () {},
                                            child: Center(
                                                child: Text("Select Date"))))
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text("M.R.P Total"),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                      ),
                                      Expanded(
                                        child: Text("1400"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text("Discount"),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                      ),
                                      Expanded(
                                        child: Text("400"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text("Amount to be paid"),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      ),
                                      Expanded(
                                        child: Text("1400"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text("Total Savings"),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                      ),
                                      Expanded(
                                        child: Text("1400"),
                                      )
                                    ],
                                  )
                                ]),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: value,
                                            onChanged: (value) {
                                              setState(() {
                                                value = value;
                                              });
                                            }),
                                        const Text(
                                          "Hard copy of reports",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Text(
                                        "Reports will be delivered within 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched."),
                                    Text("150 per person")
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Schedule",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
