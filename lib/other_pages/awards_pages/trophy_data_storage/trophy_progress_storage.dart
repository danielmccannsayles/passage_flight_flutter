import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'dart:convert';

import 'data_class.dart';

//This class reads and writes from memory.
//https://docs.flutter.dev/cookbook/persistence/reading-writing-files

class TrophyProgressStorage {
  late DataClass loadedData;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/trophies.txt');
  }

  Future<DataClass> readTrophies() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      log('Trophy contents: $contents');

      return DataClass.fromJson(json.decode(contents));
    } catch (e) {
      log(e.toString());
      // Most likely error is that this is being run for the first time.
      //return the default value in this case

      return DataClass(trophies: List.filled(50, 0), mostRecent: 100);
    }
  }

  Future<File> writeTrophies(DataClass testData) async {
    final file = await _localFile;

    // Write the file
    log('Trophies written : $testData');
    return file.writeAsString(jsonEncode(testData.toJson()));
  }
}
