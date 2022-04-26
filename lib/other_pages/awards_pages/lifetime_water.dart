import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';

class LifetimeWater extends StatefulWidget {
  const LifetimeWater({Key? key}) : super(key: key);

  @override
  State<LifetimeWater> createState() => LifetimeWaterState();
}

class LifetimeWaterState extends State<LifetimeWater> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context, 'Lifetime Water'),
      body: const Center(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: SizedBox(width: 1000),
              ))),
    );
  }
}
