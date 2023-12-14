import 'package:alemeno_health_checkup/data/health_test.dart';
import 'package:alemeno_health_checkup/home_screen.dart';
import 'package:alemeno_health_checkup/model/functions.dart';
import 'package:flutter/material.dart';

class TestsView extends StatefulWidget {
  TestsView({super.key});

  @override
  State<TestsView> createState() => _TestsViewState();
}

class _TestsViewState extends State<TestsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tests"),
      ),
      body: FutureBuilder(
        future: getTests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading..."));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Empty..."));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return healthTestTile(snapshot.data![index], context, null);
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}
