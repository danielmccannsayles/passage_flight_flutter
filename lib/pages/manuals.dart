import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class ManualsHome extends StatelessWidget {
  const ManualsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Manuals'),
      body: Stack(children: <Widget>[
        Positioned(
          top: 10,
          left: 10,
          child: ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: const Text('Go home!'),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: const Text('Go home!'),
          ),
        ),
      ]),
    );
  }
}
