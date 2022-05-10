import 'package:flutter/material.dart';
import 'package:passage_flutter/other_pages/awards_pages/trophy_data_storage/trophy_progress_model.dart';
import 'package:provider/provider.dart';
import '../../data_storage/learning_progress_model.dart';
import 'dart:developer';
import 'dart:math' hide log; //using log for development

/*Quiz Component. Used in lesson modules. Requires many parameters, including a defined height.
Defined height is because the lesson needs to know height to calculate progress made. 

Made by Daniel MS
*/

class QuizComponent extends StatefulWidget {
  final List questions;
  final List allAnswers;
  final List correctAnswers;
  final int numQuizzes;
  final bool finalQuiz;
  final Function clearProgress;

  //index starts at 0!!!
  final int index;
  final String lessonName;
  final double height;

  const QuizComponent(
      {Key? key,
      required this.clearProgress,
      required this.finalQuiz,
      required this.questions,
      required this.allAnswers,
      required this.correctAnswers,
      required this.numQuizzes,
      required this.index,
      required this.height,
      required this.lessonName})
      : super(key: key);

  @override
  State<QuizComponent> createState() => _QuizComponentState();
}

class _QuizComponentState extends State<QuizComponent> {
  //internal state - initialized as a list of 'numQuizzes'  entries.
  late List<int> _progressData;
  //
  late final numQuestions;

  //Add the index of the answer they choose to this
  //Selected answers is initialized to all have a value of 100: [100, 100];
  //If they choose the answer w/ index 0 then add a 0 to it.
  //If it's fill in the blank, give a 100 if it's wrong, and a 99 if it's right
  //it's wrong
  late List<int> _selectedAnswers;
  late List<String> _selectedStringAnswers;

  int _quizFinished = 0;

  void submit() {
    log('submitting..');
    for (int i = 0; i < numQuestions; i++) {
      if (_selectedStringAnswers[i] != widget.correctAnswers[i]) {
        return;
      }
    }
    //We got to the end so all answers were correct
    setState(() {
      _quizFinished = 1;
    });
    log('submitted successfully');

    //check if last quiz
    if (widget.finalQuiz) {
      //create trophy
      int _trophyIndex = generateTrophy();
      //add trophy
      Provider.of<TrophyProgressStore>(context, listen: false)
          .addTrophy(_trophyIndex);
      //set it as most recent
      Provider.of<TrophyProgressStore>(context, listen: false)
          .changeMostRecent(_trophyIndex);
      _quizFinished = 0;
      widget.clearProgress;
      _selectedAnswers = List.filled(_selectedAnswers.length, 0);
      Navigator.pushNamed(context, '/finishPage', arguments: _trophyIndex);
    } else {
      Provider.of<LearningProgressStore>(context, listen: false)
          .changeProgress(widget.lessonName, widget.index, 1);
    }
  }

  int generateTrophy() {
    Random _random = Random();
    int _number = _random.nextInt(49);

    Provider.of<TrophyProgressStore>(context, listen: false).addTrophy(_number);
    return _number;
  }

  List<Widget> _createQuestions() {
    List<Widget> questions = [];
    List<Widget> answers = [];
    for (int i = 0; i < numQuestions; i++) {
      int length = widget.allAnswers[i].length;
      //if length == 1 then it's a fill in the blank
      if (length == 1) {
        questions.add(Column(children: [
          Text(widget.questions[i]),
        ]));
      } else {
        answers = []; //start w/ blank answers then fill them in
        for (int j = 0; j < widget.allAnswers[i].length; j++) {
          answers.add(RadioListTile<String>(
              title: Text(widget.allAnswers[i][j]),
              value: widget.allAnswers[i][j],
              groupValue: _selectedStringAnswers[i],
              onChanged: (String? value) {
                setState(() {
                  _selectedStringAnswers[i] = value!;
                });
              }));
        }
        //at the end of each iteration of i add the question as well
        questions.add(Column(children: [
          Text(widget.questions[i]),
          ...answers,
          Text(_selectedStringAnswers[i]),
        ]));
      }
    }
    return questions;
  }

  @override
  void initState() {
    super.initState();
    numQuestions = widget.questions.length;
    _selectedAnswers = List.filled(numQuestions, 100);
    _selectedStringAnswers = List.filled(numQuestions, '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _storage = Provider.of<LearningProgressStore>(context);

    setState(() {
      //get() is the mapped version. Idk why I'm using it here I forget
      _selectedAnswers = _storage.getProgressData().get(widget.lessonName);
      _progressData = _storage.getProgressData().get(widget.lessonName);
      log('_progressData changed to: $_progressData');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: widget.height,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text('Quiz:' + widget.index.toString()),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: _createQuestions(),
              ),
            ),
            _quizFinished == 0
                ? TextButton(
                    onPressed: submit, child: const Text('Submit Quiz'))
                : const Text('Finished'),
            Text('ProgressData: ${_progressData[widget.index]}'),
            TextButton(
                onPressed: () {
                  Provider.of<LearningProgressStore>(context, listen: false)
                      .changeProgress(widget.lessonName, widget.index, 1);
                },
                child: const Text('Correct (1)')),
            TextButton(
                onPressed: () {
                  Provider.of<LearningProgressStore>(context, listen: false)
                      .changeProgress(widget.lessonName, widget.index, 0);
                },
                child: const Text('False (0)')),
          ],
        ));
  }
}
