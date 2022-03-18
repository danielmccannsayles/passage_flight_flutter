import 'package:flutter/material.dart';
import 'package:passage_flutter/pages/guided_lesson_pages/easy_data.dart';

import 'progress_storage.dart';
import 'dart:developer';

class ProgressStore extends ChangeNotifier {
  final _progress = {'mathOneProgress': 0, 'scienceOneProgress': 2};
  //eventually this will be dynamically populated from the file which it's stored in.

  EasyData _testData = EasyData(0, 0);

  EasyData? getTestData() => _testData;

  int? getProgress(String name) => _progress[name];

  final ProgressStorage progressStorage = ProgressStorage();

  void changeTest(name, value) {
    Map temp = _testData.toMap();
    temp[name] = value;

    //create list of keys so that mapping can be done dynamically
    Iterable keysList = temp.keys;

    //dynamically map the Map named temp onto the testData object because objects
    //in Flutter suck and aren't powerful unlike in JavaScript the true king.
    _testData =
        EasyData(temp[keysList.elementAt(0)], temp[keysList.elementAt(1)]);

    //store it in file
    progressStorage.writeProgress(_testData);
    log(_testData.mathOne.toString());
    notifyListeners();
  }

  ProgressStore() {
    progressStorage.readProgress().then((EasyData value) => {
          _testData = value,
          log('created with value: $_testData'),
          //notify listeners is needed here because this is a future so it takes a second to return
          //without it testData is always going to start @ 0.
          notifyListeners()
        });
  }
}
