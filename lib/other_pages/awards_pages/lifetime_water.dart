import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';
import 'package:passage_flutter/other_pages/awards_pages/water_data_storage/water_model.dart';
import 'package:provider/provider.dart';

class LifetimeWater extends StatefulWidget {
  const LifetimeWater({Key? key}) : super(key: key);

  @override
  State<LifetimeWater> createState() => LifetimeWaterState();
}

class LifetimeWaterState extends State<LifetimeWater> {
  late double _totalWater;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _totalWater = Provider.of<WaterStore>(context).getWaterData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context, 'Lifetime Water'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Text("Total Water: $_totalWater"),

                const SizedBox(height: 20),

                const SizedBox(height: 20),
                //buttons below used for testing
                TextButton(
                    onPressed: () {
                      Provider.of<WaterStore>(context, listen: false)
                          .addWater(50);
                    },
                    child: const Text("Add 50 Water")),
                TextButton(
                    onPressed: () {
                      Provider.of<WaterStore>(context, listen: false)
                          .clearWater();
                    },
                    child: const Text("Clear Water")),
              ]))),
    );
  }
}
