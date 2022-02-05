import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class FiltersHome extends StatelessWidget {
  const FiltersHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Filter'),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          child: const Text('Go home!'),
        ),
      ),
    );
  }
}
