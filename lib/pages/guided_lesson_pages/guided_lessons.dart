import 'package:flutter/material.dart';
import 'package:passage_flutter/pages/guided_lesson_pages/easy_data.dart';
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
              Text('Math One: ${progress.getTestData()!.mathOne}'),

              TextButton(
                onPressed: () {
                  progress.changeTest('mathOne', 2);
                },
                child: const Text('Change counter to 2'),
              ),
              TextButton(
                onPressed: () {
                  progress.changeTest('mathOne', 1);
                },
                child: const Text('Change counter to 1'),
              ),
              Slider(
                value: progress.getTestData()!.scienceOne.toDouble(),
                max: 10,
                divisions: 10,
                label: progress.getTestData()!.scienceOne.toDouble().toString(),
                onChanged: (double value) {
                  progress.changeTest('scienceOne', value.toInt());
                },
              ),
              const Text('The Top One Controls this one:'),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: LinearProgressIndicator(
                  value: progress.getTestData()!.scienceOne.toDouble() / 10,
                ),
              ),
            ]);
          })
        ]),
      ),
    );
  }
}
