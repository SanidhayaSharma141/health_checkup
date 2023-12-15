// ignore_for_file: use_build_context_synchronously

import 'package:alemeno_health_checkup/data/health_test.dart';
import 'package:alemeno_health_checkup/model/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              Text(
                "Includes ${test.includesHowManyTests} tests",
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

// ignore: must_be_immutable
class CartData extends StatefulWidget {
  CartData({super.key, required this.isDesktop, required this.test});
  List<Test> test;
  bool isDesktop;
  @override
  State<CartData> createState() => _CartDataState();
}

class _CartDataState extends State<CartData> {
  bool isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
          ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.test[index].testName,
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
                            '₹${widget.test[index].discountPrice}/-',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '₹${widget.test[index].priceInRupees}',
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
                  if (widget.isDesktop)
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              isDeleting = !isDeleting;
                            });
                            final resp =
                                await removeCart(test: widget.test[index]);
                            if (resp) {
                              setState(() {
                                widget.test.remove(widget.test[index]);
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
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          label: const Text("Remove"),
                        ),
                        SizedBox(width: 5),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.upload),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
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
                  if (!widget.isDesktop)
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              isDeleting = !isDeleting;
                            });
                            final resp =
                                await removeCart(test: widget.test[index]);
                            if (resp) {
                              setState(() {
                                widget.test.remove(widget.test[index]);
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
                                  color: Theme.of(context).colorScheme.primary),
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
                                  color: Theme.of(context).colorScheme.primary),
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
              );
            },
            itemCount: widget.test.length,
          ),
      ],
    );
  }
}

class DatePickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime?> onDateSelected;

  const DatePickerDialog({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );

        if (pickedDate != null) {
          widget.onDateSelected(pickedDate);
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: Text(selectedDate == null
          ? 'Select Date'
          : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"),
    );
  }
}

class TimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay?> onTimeSelected;

  const TimePickerDialog({
    required this.initialTime,
    required this.onTimeSelected,
  });

  @override
  State<TimePickerDialog> createState() => _TimePickerDialogState();
}

class _TimePickerDialogState extends State<TimePickerDialog> {
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: widget.initialTime,
        );

        if (pickedTime != null) {
          widget.onTimeSelected(pickedTime);
          setState(() {
            selectedTime = pickedTime;
          });
        }
      },
      child: Text(selectedTime == null
          ? 'Select Time'
          : "${selectedTime!.hour}:${selectedTime!.minute} hrs"),
    );
  }
}

class CartOrder extends StatefulWidget {
  CartOrder({super.key, required this.test});
  ValueNotifier<List<Test>> test;
  @override
  State<CartOrder> createState() => _CartOrderState();
}

class _CartOrderState extends State<CartOrder> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool hardCopyChecked = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.test,
      builder: (context, value, child) {
        double total = 0;
        double discount = 0;

        for (final x in widget.test.value) {
          total += x.priceInRupees;
          discount += x.priceInRupees - x.discountPrice;
        }
        return Column(
          children: [
            const SizedBox(height: 20),
            Card(
              child: Row(
                children: [
                  const Icon(Icons.calendar_month),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DatePickerDialog(
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 60)),
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                      TimePickerDialog(
                        initialTime: TimeOfDay.now(),
                        onTimeSelected: (time) {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Card(
              child: Column(
                children: [
                  _buildRow("M.R.P Total", "₹${total.toString()}"),
                  _buildRow("Discount", "₹$discount"),
                  _buildRow("Amount to be paid", "₹${total - discount}"),
                  _buildRow("Total Savings", "₹$discount", isGreen: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: hardCopyChecked,
                        onChanged: (value) {
                          setState(() {
                            hardCopyChecked = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        "Hard copy of reports",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Text(
                    "Reports will be delivered within 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched.",
                  ),
                  const Text(
                    "₹150 per person",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedDate == null || selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Select date and time first")));
                    return;
                  }
                  await removeCart(testList: widget.test.value);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child:
                            contentBox(context, selectedDate!, selectedTime!),
                      );
                    },
                  );

                  Navigator.of(context).pop(true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  "Schedule",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget contentBox(BuildContext context, DateTime date, TimeOfDay time) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Appointment Scheduled Successfully',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Date: ${date.day}-${date.month}-${date.year}\nTime: ${time.hour}:${time.minute} hrs',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

Widget _buildRow(String label, String value, {bool isGreen = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isGreen ? Colors.green : null,
        ),
      ),
    ],
  );
}

class ButtonWidget extends StatefulWidget {
  ButtonWidget({super.key, required this.isDesktop, required this.test});
  bool isDesktop;
  Test test;
  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isAdding = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.isDesktop)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (!widget.test.isInCart) {
                    setState(() {
                      isAdding = !isAdding;
                    });
                    try {
                      await FirebaseFirestore.instance
                          .collection('Cart')
                          .doc(widget.test.testName)
                          .set({"test": true});
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
                      .copyWith(color: Colors.white, fontSize: 8),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  "View Details",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white, fontSize: 8),
                ),
              ),
            ],
          ),
        if (!widget.isDesktop)
          Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.4 / 1.5 * 0.1,
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () async {
                  if (!widget.test.isInCart) {
                    setState(() {
                      isAdding = !isAdding;
                    });
                    try {
                      await FirebaseFirestore.instance
                          .collection('Cart')
                          .doc(widget.test.testName)
                          .set({"test": true});
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
                      .copyWith(color: Colors.white, fontSize: 8),
                ),
              ),
            ),
          ),
        if (!widget.isDesktop)
          Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4 / 1.5 * 0.1,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
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
          ),
      ],
    );
  }
}
