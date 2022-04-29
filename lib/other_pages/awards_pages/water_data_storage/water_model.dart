import 'package:flutter/material.dart';

import 'water_storage.dart';
import 'dart:developer';

class WaterStore extends ChangeNotifier {
  int _totalWater = 0;

  int getWaterData() => _totalWater;

  final WaterStorage progressStorage = WaterStorage();

  void clearWater() {
    _totalWater = 0;

    progressStorage.writeWater(_totalWater);
    notifyListeners();
  }

  void addWater(int amount) {
    _totalWater += amount;

    progressStorage.writeWater(_totalWater);
    notifyListeners();
  }

  WaterStore() {
    progressStorage.readWater().then((int value) {
      _totalWater = value;
      log('Total water initialized as: $_totalWater');
      notifyListeners();
    });
  }
}
