import 'package:flutter/material.dart';
import 'package:passage_flutter/components/tita_text_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _height = 150;

  final double _width = 200;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Home Page'),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          child: Column(children: [
            const Text('Dive Back in'),
            TextButton(onPressed: () {}, child: const Text('Lesson 1')),
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Row(
            children: [
              const Text('Statistics:'),
              const SizedBox(width: 20),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lifetimeWater');
                  },
                  child: const Text('Water Usage')),
              const SizedBox(width: 20),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/trophyRoom');
                  },
                  child: const Text('Trophy Room')),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Wrap(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/teacherResources');
                    },
                    child: const Text('Teacher Resources')),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/filterResources');
                    },
                    child: const Text('Filter Resources')),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/aboutResources');
                    },
                    child: const Text('About L.I.F.E. / More Resources')),
              ],
            )),
      ],
    );
  }
}

//OBSOLETE NOW
class MeetTheStudents extends StatelessWidget {
  const MeetTheStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Hi, Welcome to your L.I.F.E. tablet & accompanying water filter! You\'re currently on the home page. Click on the buttons down below to go to the filter on the right, and the learning lessons, on the left.',
                style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 100,
            ),
            TitaTextBar(
                length: 1,
                happyBool: true,
                text:
                    'LIFE stands for LATAM Filter for Education and is a university project made by 5 engineering and 4 public health students! ')
          ],
        ));
  }
}
