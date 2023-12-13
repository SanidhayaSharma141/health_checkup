import 'package:alemeno_health_checkup/data/health_test.dart';
import 'package:flutter/material.dart';

Widget healthTestWidget(Test test) => Card(
      elevation: 10,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                border: Border.all(style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(test.testName),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Includes ${test.includesHowManyTests} tests",
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: test.isSafe ? Colors.greenAccent : Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Icon(test.isSafe
                    ? Icons.check_circle_outline
                    : Icons.cancel_outlined),
              )
            ],
          ),
          Text("Get reports in 24 hours"),
          Center(
            child: Row(
              children: [
                Text(
                  '₹${test.priceInRupees}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '₹${test.discountPrice}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Add to Cart",
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("View Details"))
        ],
      ),
    );

Widget cartData(List<Test> test, BuildContext context, bool isDesktop) =>
    Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            "Pathology Tests",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
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
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isDesktop)
                  Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius:
                                          BorderRadius.circular(16)))),
                          label: const Text("Remove")),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.upload),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius:
                                          BorderRadius.circular(16)))),
                          label: const Text(
                            "Upload prescription(optional)",
                            overflow: TextOverflow.clip,
                          )),
                    ],
                  ),
                if (!isDesktop)
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  borderRadius: BorderRadius.circular(16)))),
                      label: const Text("Remove")),
                SizedBox(
                  height: 5,
                ),
                if (!isDesktop)
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  borderRadius: BorderRadius.circular(16)))),
                      label: const Text(
                        "Upload prescription(optional)",
                        overflow: TextOverflow.clip,
                      )),
                const Divider(),
                SizedBox(height: 15),
              ],
            );
          },
          itemCount: 2,
        ),
      ],
    );

Widget cartOrder(BuildContext context) => Column(
      children: [
        SizedBox(height: 20),
        Card(
          child: Row(
            children: [
              Icon(Icons.calendar_month),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(color: Colors.grey),
                    ),
                  ),
                  onPressed: () {},
                  child: Center(child: Text("Select Date")),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("M.R.P Total"),
                  Text("1400"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Discount"),
                  Text("400"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Amount to be paid"),
                  Text("1400"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Savings"),
                  Text("1400"),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Card(
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text(
                    "Hard copy of reports",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                  "Reports will be delivered within 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched."),
              Text("150 per person")
            ],
          ),
        ),
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
    );
