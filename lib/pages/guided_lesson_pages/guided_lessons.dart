import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';

import './progress_model.dart';
import 'package:provider/provider.dart';

class GuidedLessons extends StatelessWidget {
  const GuidedLessons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Guided Lessons'),
      body: Center(
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: const Text('Go home!'),
          ),
          Consumer<ProgressStore>(builder: (context, progress, child) {
            return Column(children: [
              // Text('math progress: ${progress.getProgress('mathOneProgress')}'),
              // Text(
              //     'science progress: ${progress.getProgress('scienceOneProgress')}'),
              // TextButton(
              //     onPressed: () {
              //       progress.changeProgress('mathOneProgress', 2);
              //     },
              //     child: const Text('Press me to change progress'))
              Text('test data: ${progress.getTestData()}'),
              TextButton(
                onPressed: () {
                  progress.changeTest(2);
                },
                child: const Text('Press me to change test to two'),
              ),
              TextButton(
                onPressed: () {
                  progress.changeTest(1);
                },
                child: const Text('Press me to change test to 1'),
              )
            ]);
          })
        ]),
      ),
    );
  }
}
