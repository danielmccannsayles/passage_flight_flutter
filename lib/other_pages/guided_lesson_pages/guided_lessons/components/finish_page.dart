import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => FinishPageState();
}

class FinishPageState extends State<FinishPage> {
  int _trophyIndex = 100;

  @override
  Widget build(BuildContext context) {
    _trophyIndex = ModalRoute.of(context)?.settings.arguments != null
        ? ModalRoute.of(context)?.settings.arguments as int
        : 100;

    return Scaffold(
      appBar: secondaryAppBar(context, 'Lesson Complete'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text('Congratulations!'),
                  const Text('You discoverd a __ award'),
                  const SizedBox(height: 20),
                  Text(_trophyIndex == 100
                      ? 'No Trophy to display'
                      : 'Your trophy is $_trophyIndex'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () => {
                                //sends homepage so that the back button on trophy room page takes the user home
                                Navigator.pushNamed(context, '/'),
                                Navigator.pushNamed(context, '/trophyRoom')
                              },
                          child: const Text(
                              'Check out your item in the Trophy Room')),
                      TextButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: const Text('Go back to learning adventures'))
                    ],
                  ),
                ],
              ))),
    );
  }
}
