import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => FinishPageState();
}

class FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context, 'About LIFE'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text('Congratulations!'),
                  const Text('You discoverd a __ award'),
                  const SizedBox(height: 100),
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
                          onPressed: () => {
                                //sends user to homepage (learning page argument)
                                Navigator.pushNamed(context, '/', arguments: 2)
                              },
                          child: const Text('Go back to learning adventures'))
                    ],
                  ),
                ],
              ))),
    );
  }
}
