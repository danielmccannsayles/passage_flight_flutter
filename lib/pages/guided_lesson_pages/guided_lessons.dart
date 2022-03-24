import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';

import './progress_model.dart';
import 'package:provider/provider.dart';

class GuidedLessons extends StatefulWidget {
  const GuidedLessons({Key? key}) : super(key: key);

  @override
  State<GuidedLessons> createState() => _GuidedLessonsState();
}

class _GuidedLessonsState extends State<GuidedLessons> {
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
          Column(children: [
            // Text('math progress: ${progress.getProgress('mathOneProgress')}'),
            // Text(
            //     'science progress: ${progress.getProgress('scienceOneProgress')}'),
            // TextButton(
            //     onPressed: () {
            //       progress.changeProgress('mathOneProgress', 2);
            //     },
            //     child: const Text('Press me to change progress'))

            const Text('Science Progress Test:'),
            Text(Provider.of<ProgressStore>(context)
                .getProgressData()
                .scienceOne[0]
                .toString()),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(40),
                child: LinearProgressIndicator(
                  value: Provider.of<ProgressStore>(context)
                          .getProgressData()
                          .scienceOne[0]
                          .toDouble() /
                      100,
                )),
          ])
        ]),
      ),
    );
  }
}
