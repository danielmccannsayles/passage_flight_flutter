import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class ManualsHome extends StatefulWidget {
  const ManualsHome({Key? key}) : super(key: key);

  @override
  State<ManualsHome> createState() => _ManualsHomeState();
}

class _ManualsHomeState extends State<ManualsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Manuals'),
      body: Column(children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Go Home'),
            ),
          ],
        ),
      ]),
    );
  }
}
