import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';

import 'progress_storage.dart';
import 'dart:developer';

class ProgressStore extends ChangeNotifier {
  final _progress = {'mathOneProgress': 0, 'scienceOneProgress': 2};
  //eventually this will be dynamically populated from the file which it's stored in.
  //https://docs.flutter.dev/cookbook/persistence/reading-writing-files

  int _testData = 0;

  int? getTestData() => _testData;

  int? getProgress(String name) => _progress[name];

  final ProgressStorage progressStorage = ProgressStorage();

  void changeProgress(String name, int progress) {
    _progress[name] = progress;
    notifyListeners();
  }

  void changeTest(int test) {
    _testData = test;
    //store it in file
    progressStorage.writeProgress(test);
    notifyListeners();
  }

  ProgressStore() {
    progressStorage.readProgress().then((int value) => {
          _testData = value,
          log('created with value: $_testData'),
          //notify listeners is needed here because this is a future so it takes a second to return
          //without it testData is always going to start @ 0.
          notifyListeners()
        });
  }
}
