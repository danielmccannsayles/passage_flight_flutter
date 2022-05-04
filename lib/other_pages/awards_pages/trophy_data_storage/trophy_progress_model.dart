import 'package:flutter/material.dart';
import 'data_class.dart';

import 'trophy_progress_storage.dart';
import 'dart:developer';

class TrophyProgressStore extends ChangeNotifier {
  DataClass _trophyData = DataClass(trophies: List.filled(50, 0));

  DataClass getTrophyData() => _trophyData;

  final TrophyProgressStorage progressStorage = TrophyProgressStorage();

  void clearTrophies() {
    _trophyData = DataClass(trophies: List.filled(50, 0));
    log('trophies cleared');

    progressStorage.writeTrophies(_trophyData);
    notifyListeners();
  }

  void addTrophy(int index) {
    _trophyData.trophies[index] = 1;
    //store it in file
    progressStorage.writeTrophies(_trophyData);
    log(_trophyData.toString());
    notifyListeners();
  }

  void subtractTrophy(int index) {
    _trophyData.trophies[index] = 0;
    //store it in file
    progressStorage.writeTrophies(_trophyData);
    log(_trophyData.toString());
    notifyListeners();
  }

  TrophyProgressStore() {
    progressStorage.readTrophies().then((DataClass value) {
      _trophyData = value;
      log('trophies list initialized as: $_trophyData');
      notifyListeners();
    });
  }
}
