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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/scienceLessonOne');
            },
            child: const Text('Open Science Lesson One'),
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
              Text('Math One: ${progress.getTestData().mathOne}'),

              TextButton(
                onPressed: () {
                  progress.changeProgress('mathOne', 2);
                },
                child: const Text('Change counter to 2'),
              ),
              TextButton(
                onPressed: () {
                  progress.changeProgress('mathOne', 1);
                },
                child: const Text('Change counter to 1'),
              ),
              Slider(
                value: progress.getTestData().mathOne.toDouble(),
                max: 10,
                divisions: 10,
                label: progress.getTestData().mathOne.toDouble().toString(),
                onChanged: (double value) {
                  progress.changeProgress('scienceOne', value.toInt());
                },
              ),
              const Text('The Top One Controls this one:'),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: LinearProgressIndicator(
                  value: progress.getTestData().mathOne.toDouble() / 10,
                ),
              ),
            ]);
          })
        ]),
      ),
    );
  }
}
