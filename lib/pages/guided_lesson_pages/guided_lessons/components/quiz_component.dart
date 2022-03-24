import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../progress_model.dart';
import 'dart:developer';

class QuizComponent extends StatefulWidget {
  final List questions;
  final List allAnswers;
  final List correctAnswers;
  final int numQuizzes;

  //index starts at 1 - 0 should never be passed in.
  final int index;
  final int numQuestions;
  final String lessonName;

  const QuizComponent(
      {Key? key,
      required this.questions,
      required this.allAnswers,
      required this.correctAnswers,
      required this.numQuizzes,
      required this.index,
      required this.numQuestions,
      required this.lessonName})
      : super(key: key);

  @override
  State<QuizComponent> createState() => _QuizComponentState();
}

class _QuizComponentState extends State<QuizComponent> {
  //internal state - initialized as a list of 'numQuizzes'  entries.
  List<int> _progressData = [0, 0, 0];

  //Add the answer they choose to this
  late List<String> _answeredQuestions;

  int quizFinished = 0;

  //called when they press submit
  void submit() {
    for (int i = 0; i < widget.numQuestions; i++) {
      if (_answeredQuestions[i] != widget.correctAnswers[i]) {
        return;
      }
    }
    //TODO: Provider.of<ProgressStore>(context, listen: false).changeTest('mathOne', 1);
  }

  //called when an answer is chosen
  void addAnswer(int index, String answer) {
    setState(() {
      _answeredQuestions[index] = answer;
    });
  }

  List<Widget> _createQuestions() {
    List<Widget> questions = [];
    for (int i = 0; i < widget.numQuestions; i++) {
      questions.add(Text(widget.questions[i]));
      //TODO: create custom widget w/ answers displayed.
    }
    return questions;
  }

  @override
  void initState() {
    super.initState();
    //numQuizzes+1 because index 0 is reserved for progress
    _progressData = List.filled(widget.numQuizzes + 1, 0);
    log('_progressData: $_progressData');
    _answeredQuestions = List.filled(widget.numQuestions, '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _storage = Provider.of<ProgressStore>(context);

    setState(() {
      //has to be mapped so we can pass a dynamic parameter and get back a value.
      //VERY ANNOYING YOU suck fluTTer
      _progressData = _storage.getProgressData().get(widget.lessonName);
      log('_progressData changed to: $_progressData');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const Text('hey'),
            const Text('Quiz:'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:
                    _createQuestions(), // <<<<< Note this change for the return type
              ),
            ),
            Text('${_progressData[widget.index]}'),
            TextButton(
                onPressed: () {
                  Provider.of<ProgressStore>(context, listen: false)
                      .changeProgress(widget.lessonName, widget.index, 1);
                },
                child: const Text('Correct (1)')),
            TextButton(
                onPressed: () {
                  Provider.of<ProgressStore>(context, listen: false)
                      .changeProgress(widget.lessonName, widget.index, 0);
                },
                child: const Text('False (0)')),
          ],
        ));
  }
}
