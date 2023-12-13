import 'package:alemeno_health_checkup/model/functions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'data/health_test.dart';
import 'model/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool value = false;
  // List<Test> test = ;
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    children: [Icon(Icons.hourglass_empty), Text("Empty Cart")],
                  ),
                );
              }
              return Column(
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
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: cartData(
                                        snapshot.data!, context, true)),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      children: [
                                        cartOrder(snapshot.data!, context)
                                      ],
                                    )),
                              ],
                            )
                          : Column(
                              children: [
                                cartData(snapshot.data!, context, false),
                                cartOrder(snapshot.data!, context)
                              ],
                            )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
