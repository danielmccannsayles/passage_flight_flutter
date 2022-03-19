import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'dart:convert';

import 'easy_data.dart';

//This class reads and writes from memory.
//https://docs.flutter.dev/cookbook/persistence/reading-writing-files

class ProgressStorage {
  late EasyData loadedData;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/test.txt');
  }

  Future<EasyData> readProgress() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      log('contents: $contents');

      return EasyData.fromJson(json.decode(contents));
    } catch (e) {
      log(e.toString());
      // Most likely error is that this is being run for the first time.
      //return the default value in this case

      //hardcoded data here - ideally should be dynamic but too much work
      return EasyData(mathOne: 0, scienceOne: [0, 0]);
    }
  }

  Future<File> writeProgress(EasyData testData) async {
    final file = await _localFile;

    // Write the file
    log('test Data saved: $testData');
    return file.writeAsString(jsonEncode(testData.toJson()));
  }
}
