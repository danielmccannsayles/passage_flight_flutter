import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'dart:convert';

import 'easy_data.dart';

//This class reads and writes from memory.
//https://docs.flutter.dev/cookbook/persistence/reading-writing-files

class LearningProgressStorage {
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
    //TODO: If getting an error after adding 0's to the list then comment out
    //some of this - it's probably looking at old data that was saved.
    //run this when needed to reset
    // return EasyData(mathOne: [0, 0], scienceOne: [0, 0]);
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
      //TODO: make this dynamic somehow
      //TODO: Possibly create another permanent data storage that stores global variables such as..
      //TODO: Amount of quizzes - or just make a new file that defines it and import
      //that file lol
      return EasyData(mathOne: [0, 0], scienceOne: [0, 0]);
    }
  }

  Future<File> writeProgress(EasyData testData) async {
    final file = await _localFile;

    // Write the file
    log('Progress saved (Science One): ${testData.scienceOne}');
    return file.writeAsString(jsonEncode(testData.toJson()));
  }
}
