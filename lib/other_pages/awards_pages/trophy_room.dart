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

    _trophyList =
        Provider.of<TrophyProgressStore>(context).getTrophyData().trophies;

    log('_trophy list changed to: $_trophyList');
  }

  List<Widget> _getImageList() {
    List<Widget> list = [];
    for (var el in _trophyList) {
      list.add(el == 1
          ? const Image(image: AssetImage('trophyImages/checkmark.jpg'))
          : const Image(image: AssetImage('trophyImages/redx.jpg')));
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
                    Wrap(
                      direction: Axis.horizontal,
                      children: _getImageList(),
                    ),
                  ],
                ))));
  }
}
