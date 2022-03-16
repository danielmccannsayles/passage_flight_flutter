import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';
import 'dart:developer';

//This class reads and writes from memory.
//https://docs.flutter.dev/cookbook/persistence/reading-writing-files

class ProgressStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/test.txt');
  }

  Future<int> readProgress() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      log('contents: $contents');

      return int.parse(contents);
    } catch (e) {
      log(e.toString());
      // Most likely error is that this is being run for the first time.
      //return the default value in this case
      return 0;
    }
  }

  Future<File> writeProgress(int testData) async {
    final file = await _localFile;

    // Write the file
    log('test Data saved: $testData');
    return file.writeAsString('$testData');
  }
}
