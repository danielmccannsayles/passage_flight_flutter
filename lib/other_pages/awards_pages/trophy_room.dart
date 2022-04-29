import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';
import 'dart:developer';
import 'trophy_data_storage/trophy_progress_model.dart';
import 'package:provider/provider.dart';

class TrophyRoom extends StatefulWidget {
  const TrophyRoom({Key? key}) : super(key: key);

  @override
  State<TrophyRoom> createState() => TrophyRoomState();
}

class TrophyRoomState extends State<TrophyRoom> {
  late List _trophyList;
  late List<Widget> _imagesList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _trophyList =
          Provider.of<TrophyProgressStore>(context).getTrophyData().trophies;
    });

    log('_trophy list changed to: $_trophyList');
  }

  List<Widget> _getImageList() {
    List<Widget> list = [];
    for (int i = 0; i < _trophyList.length; i++) {
      list.add(Column(children: [
        _trophyList[i] == 1
            ? const Image(
                image: AssetImage('assets/trophyImages/checkmark.jpg'),
                height: 30,
                width: 30)
            : const Image(
                image: AssetImage('assets/trophyImages/redx.jpg'),
                height: 30,
                width: 30,
              ),
        //button for testing that trophy saving is working:)
        TextButton(
            onPressed: () {
              _trophyList[i] == 0
                  ? Provider.of<TrophyProgressStore>(context, listen: false)
                      .addTrophy(i)
                  : Provider.of<TrophyProgressStore>(context, listen: false)
                      .subtractTrophy(i);
            },
            child: const Text("Turn on or off")),
      ]));
    }
    return list;
  }

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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: _getImageList(),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
