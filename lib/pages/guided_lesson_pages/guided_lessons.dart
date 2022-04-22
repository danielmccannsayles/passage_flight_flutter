import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_theme.dart';
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
    return Center(
        child: Row(
      children: [
        Flexible(
          flex: 1,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppTheme.colors.buttonBlue)),
                onPressed: () {
                  Navigator.of(context).pushNamed('/scienceLessonOne');
                },
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      const Text('Science Lesson One'),
                      Text(Provider.of<ProgressStore>(context)
                          .getProgressData()
                          .scienceOne[0]
                          .toString()),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: LinearProgressIndicator(
                            color: Colors.blue,
                            backgroundColor: AppTheme.colors.lightBlue,
                            value: Provider.of<ProgressStore>(context)
                                    .getProgressData()
                                    .scienceOne[0]
                                    .toDouble() /
                                100,
                          )),
                    ])),
              ),
            ),

            // Text('math progress: ${progress.getProgress('mathOneProgress')}'),
            // Text(
            //     'science progress: ${progress.getProgress('scienceOneProgress')}'),
            // TextButton(
            //     onPressed: () {
            //       progress.changeProgress('mathOneProgress', 2);
            //     },
            //     child: const Text('Press me to change progress'))

            const SizedBox(
              height: 10,
            ),
          ]),
        ),
        Flexible(
            flex: 1,
            child: Column(
              children: [
                const Text('Teacher Files'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/lessonsPage');
                  },
                  child: const Text('View PDF Files'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppTheme.colors.buttonBlue)),
                ),
              ],
            ))
      ],
    ));
  }
}
