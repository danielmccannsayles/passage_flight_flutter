import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';

class TrophyRoom extends StatefulWidget {
  const TrophyRoom({Key? key}) : super(key: key);

  @override
  State<TrophyRoom> createState() => TrophyRoomState();
}

class TrophyRoomState extends State<TrophyRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: secondaryAppBar(context, 'Trophy Room'),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text('Trophy Page'),
                    Wrap(
                        //TODO(Daniel): ADD a bunch of trophies here that turn on or off depending on if they've been found
                        ),
                  ],
                ))));
  }
}
