import 'package:flutter/material.dart';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'dart:developer';

import 'components/guided_app_bar.dart';

import 'components/quiz_component.dart';
import '../progress_model.dart';
import 'package:provider/provider.dart';
import 'components/quiz_object.dart';

//Define all the quiz objects here - they won't change
final quizOneJson = QuizJson([
  "what's 2+2",
  "What's 3+3"
], [
  ["4", "5", "6"],
  ["4", "7", "6"]
], [
  "4",
  "6"
]);

//Begin science lesson widget
class ScienceLesson extends StatefulWidget {
  const ScienceLesson({Key? key}) : super(key: key);

  @override
  State<ScienceLesson> createState() => ScienceLessonState();
}

class ScienceLessonState extends State<ScienceLesson> {
  final ScrollController _scrollController = ScrollController();

  final throttle =
      Throttle<double>(const Duration(milliseconds: 500), initialValue: 0);

  //what the current position is
  double _scrollPosition = 0;

  //what the current progress is set to
  double _currentProgress = 0;

  //passed to app bar as a visual indicator of progress
  int _progressVisual = 0;

  //defined in WidgetsBinding so as not to query scrollController before it attaches
  double _scrollHeight = 0;

  int numQuizzes = 2;

  void clearProgress() {
    setState(() {
      _currentProgress = 0;
      _progressVisual = 0;
      Provider.of<ProgressStore>(context, listen: false)
          .clearProgress('scienceOne');
    });
  }

  VoidCallback? updateScroll(double value) {
    setState(() {
      _scrollPosition = value;
      if (_scrollPosition > _currentProgress) {
        _currentProgress = _scrollPosition;
        //This is effective integer division - turns it from double to int while dividing
        _progressVisual = _currentProgress * 100 ~/ _scrollHeight;
        log('new progress reached: $_currentProgress');

        Provider.of<ProgressStore>(context, listen: false)
            .changeProgress('scienceOne', 0, _progressVisual);
      }
    });
    return null;
  }

  //In didChange Dependencies context is bound so we can use Provider.of(context)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _progressVisual =
        Provider.of<ProgressStore>(context).getProgressData().scienceOne[0];

    _currentProgress = _progressVisual / 100 * _scrollHeight;

    log('_progressvisual changed to: $_progressVisual');
  }

  @override
  initState() {
    super.initState();
    //Define normal progress here real quick by inverting the other formula

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _currentProgress = _progressVisual / 100 * _scrollHeight;

      if (_scrollController.hasClients) {
        //set scroll to current position
        _scrollController.jumpTo(_currentProgress);
        log('test scorll contt');

        //add listener
        _scrollController.addListener(
            () => throttle.setValue(_scrollController.position.pixels));

        //TODO: SCROLL Height is equal to viewport PLUS THE HEIGHT OF ALL QUIZZES
        _scrollHeight = _scrollController.position.viewportDimension;

        throttle.values.listen((value) => updateScroll(value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guidedAppBar(context, 'Science Lesson One', _currentProgress,
          _scrollController, _progressVisual, clearProgress),
      body: ListView(controller: _scrollController, children: [
        ElevatedButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          child: const Text('Go Home'),
        ),
        Text('Scroll value: $_scrollPosition'),
        const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque accumsan libero a lacinia fermentum. Mauris ac tellus et ante fringilla faucibus. Quisque hendrerit odio non magna posuere, sed accumsan nisi rutrum. Suspendisse quis tempor magna. Nullam velit elit, lobortis elementum molestie et, hendrerit ultricies magna. Etiam est leo, bibendum nec feugiat sed, varius in sem. Morbi imperdiet gravida libero, euismod eleifend nisl interdum ut. In nec est turpis. Duis commodo turpis nulla, at tempor felis vehicula nec. Nulla libero velit, mollis ac risus ac, fringilla luctus urna. Integer dapibus efficitur facilisis. Nullam malesuada turpis et lorem vehicula varius. Aliquam luctus, nisi sed dictum vulputate, risus nulla tempor felis, sit amet mattis ante purus quis enim. Fusce malesuada et orci non ullamcorper. Vivamus vel urna ipsum. Praesent eget vestibulum justo. Aenean luctus risus dui, lobortis dapibus nisl vulputate nec. Cras iaculis neque eget porta lobortis. Etiam in mi at dui finibus venenatis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas varius metus eu ipsum pretium molestie nec et ante. Aliquam pharetra metus in ornare tincidunt. Donec bibendum efficitur purus sit amet pretium. Nam quis bibendum sapien. Aenean fermentum venenatis felis, in tristique turpis imperdiet vitae. Sed venenatis pretium elementum. Morbi vehicula convallis laoreet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla fringilla suscipit est, eu lobortis ex faucibus sed. Curabitur nisi nulla, consectetur et dignissim euismod, porttitor efficitur purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam congue, nulla sed sollicitudin posuere, ipsum velit tempus mi, sed fermentum dolor tellus quis sem. In sagittis nisl non quam blandit feugiat. Mauris a ex eu nibh vestibulum ornare sed nec massa. Praesent rutrum mollis tortor. Aenean urna erat, semper eu lorem ut, sollicitudin condimentum massa. Donec mollis eros vitae nunc consectetur, at pretium ante varius. Aliquam nec varius dolor. Mauris sollicitudin tortor sed magna pellentesque molestie. Proin enim urna, maximus eu imperdiet non, vehicula sit amet quam. Sed feugiat, ligula ac feugiat venenatis, nisl arcu accumsan mauris, non lobortis velit dui sit amet diam. Cras eget turpis placerat, euismod ex at, condimentum sapien. Nam scelerisque viverra lorem, molestie finibus erat auctor vitae. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam fringilla molestie nulla eget suscipit. Aliquam sit amet leo dui. Pellentesque laoreet turpis vitae urna bibendum, non accumsan nunc tristique. Mauris at ipsum sit amet ipsum laoreet venenatis. Donec id orci vel ante ultrices varius at id urna. Nulla aliquam est sed diam sagittis, in facilisis est fermentum. Etiam luctus bibendum diam, id ultrices lacus ornare vitae.'),
        QuizComponent(
          questions: quizOneJson.questions,
          allAnswers: quizOneJson.allAnswers,
          correctAnswers: quizOneJson.correctAnswers,
          numQuizzes: numQuizzes,
          index: 1,
          numQuestions: 2,
          lessonName: 'scienceOne',
        ),
        QuizComponent(
          questions: quizOneJson.questions,
          allAnswers: quizOneJson.allAnswers,
          correctAnswers: quizOneJson.correctAnswers,
          numQuizzes: numQuizzes,
          index: 2,
          numQuestions: 2,
          lessonName: 'scienceOne',
        ),
        const SizedBox(
          height: 500,
        ),
        const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque accumsan libero a lacinia fermentum. Mauris ac tellus et ante fringilla faucibus. Quisque hendrerit odio non magna posuere, sed accumsan nisi rutrum. Suspendisse quis tempor magna. Nullam velit elit, lobortis elementum molestie et, hendrerit ultricies magna. Etiam est leo, bibendum nec feugiat sed, varius in sem. Morbi imperdiet gravida libero, euismod eleifend nisl interdum ut. In nec est turpis. Duis commodo turpis nulla, at tempor felis vehicula nec. Nulla libero velit, mollis ac risus ac, fringilla luctus urna. Integer dapibus efficitur facilisis. Nullam malesuada turpis et lorem vehicula varius. Aliquam luctus, nisi sed dictum vulputate, risus nulla tempor felis, sit amet mattis ante purus quis enim. Fusce malesuada et orci non ullamcorper. Vivamus vel urna ipsum. Praesent eget vestibulum justo. Aenean luctus risus dui, lobortis dapibus nisl vulputate nec. Cras iaculis neque eget porta lobortis. Etiam in mi at dui finibus venenatis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas varius metus eu ipsum pretium molestie nec et ante. Aliquam pharetra metus in ornare tincidunt. Donec bibendum efficitur purus sit amet pretium. Nam quis bibendum sapien. Aenean fermentum venenatis felis, in tristique turpis imperdiet vitae. Sed venenatis pretium elementum. Morbi vehicula convallis laoreet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla fringilla suscipit est, eu lobortis ex faucibus sed. Curabitur nisi nulla, consectetur et dignissim euismod, porttitor efficitur purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam congue, nulla sed sollicitudin posuere, ipsum velit tempus mi, sed fermentum dolor tellus quis sem. In sagittis nisl non quam blandit feugiat. Mauris a ex eu nibh vestibulum ornare sed nec massa. Praesent rutrum mollis tortor. Aenean urna erat, semper eu lorem ut, sollicitudin condimentum massa. Donec mollis eros vitae nunc consectetur, at pretium ante varius. Aliquam nec varius dolor. Mauris sollicitudin tortor sed magna pellentesque molestie. Proin enim urna, maximus eu imperdiet non, vehicula sit amet quam. Sed feugiat, ligula ac feugiat venenatis, nisl arcu accumsan mauris, non lobortis velit dui sit amet diam. Cras eget turpis placerat, euismod ex at, condimentum sapien. Nam scelerisque viverra lorem, molestie finibus erat auctor vitae. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam fringilla molestie nulla eget suscipit. Aliquam sit amet leo dui. Pellentesque laoreet turpis vitae urna bibendum, non accumsan nunc tristique. Mauris at ipsum sit amet ipsum laoreet venenatis. Donec id orci vel ante ultrices varius at id urna. Nulla aliquam est sed diam sagittis, in facilisis est fermentum. Etiam luctus bibendum diam, id ultrices lacus ornare vitae.'),
      ]),
    );
  }
}
