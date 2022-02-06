import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'package:passage_flutter/theme/app_theme.dart';

import 'dart:developer';

class FiltersHome extends StatefulWidget {
  const FiltersHome({Key? key}) : super(key: key);

  @override
  State<FiltersHome> createState() => _FiltersHomeState();
}

class _FiltersHomeState extends State<FiltersHome> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Filter'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Go home!'),
              ),
            ),
            Wrap(children: [
              SizedBox(
                width: 400,
                child: Column(children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/manualsHome');
                        },
                        child: const Text('Bluetooth settings'),
                      ),
                      Row(
                        children: [
                          const Text('Enable Bluetooth'),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                log(isSwitched.toString());
                              });
                            },
                            activeTrackColor: AppTheme.colors.lightBlue,
                            activeColor: AppTheme.colors.darkBlue,
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Paired Devices'),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Connect'),
                      ),
                    ],
                  )
                ]),
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/manualsHome');
                    },
                    child: const Text(
                      'Manual',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
