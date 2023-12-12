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
