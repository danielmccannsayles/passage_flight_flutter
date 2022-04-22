import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../progress_model.dart';
import 'dart:developer';

/*Quiz Component. Used in lesson modules. Requires many parameters, including a defined height.
Defined height is because the lesson needs to know height to calculate progress made. 

Made by Daniel MS
*/

class QuizComponent extends StatefulWidget {
  final List questions;
  final List allAnswers;
  final List correctAnswers;
  final int numQuizzes;

  //index starts at 1 - 0 should never be passed in.
  final int index;
  final String lessonName;
  final double height;

  const QuizComponent(
      {Key? key,
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

  int quizFinished = 0;

  //TODO: test submit function
  void submit() {
    for (int i = 0; i < numQuestions; i++) {
      if (_selectedAnswers[i] == 99) {
        //do nothing - it was right & fill in the blank
      } else if (_selectedAnswers[i] == 100) {
        //it was fill in the blank and wrong
        return;
      }
      //It was multiple choice, try it out
      else if (widget.allAnswers[_selectedAnswers[i]] !=
          widget.correctAnswers[i]) {
        return;
      }
    }
    //We got to the end so update the progress.
    Provider.of<ProgressStore>(context, listen: false)
        .changeProgress(widget.lessonName, widget.index, 1);
  }

  void addAnswer(int index, int answerIndex) {
    setState(() {
      _selectedAnswers[index] = answerIndex;
    });
    log(_selectedAnswers.toString());
  }

  List<Widget> _createQuestions() {
    List<Widget> questions = [];
    List<Widget> answers = [];
    for (int i = 0; i < numQuestions; i++) {
      //if length == 1 then it's a fill in the blank
      int length = widget.allAnswers[i].length;
      if (length == 1) {
        questions.add(Column(children: [
          Text(widget.questions[i]),
          Row(children: [
            //TODO: FIX change to radiolisttile
            // Checkbox(

            //     onChanged: (value) => {
            //           //if correct set to 99.
            //           //if incorrect set to 100.
            //           if (widget.allAnswers[i][0] ==
            //               widget.correctAnswers[i][0])
            //             {addAnswer(i, 99)}
            //           else
            //             {addAnswer(i, 100)}
            //         },
            //     ),
            //TODO: add a text input
          ])
        ]));
      } else {
        answers = []; //clear answers each round
        for (int j = 0; j < widget.allAnswers[i].length; j++) {
          answers.add(Row(children: [
            IconButton(
                onPressed: () => addAnswer(i, j),
                icon: const Icon(Icons.check_box)),
            Text(widget.allAnswers[i][j]),
          ]));
        }
        //at the end of each iteration of i add the question to
        questions
            .add(Column(children: [Text(widget.questions[i]), ...answers]));
      }
    }
    return questions;
  }

  @override
  void initState() {
    super.initState();
    numQuestions = widget.questions.length;
    //numQuizzes+1 because index 0 is reserved for progress
    // _progressData = List.filled(widget.numQuizzes + 1, 0);
    // //TODO: see if progress Data needs to be initialized here or if it can be initialized in didChangeDependencies
    // log('_progressData initialized as: $_progressData');
    _selectedAnswers = List.filled(numQuestions, 100);
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
        height: widget.height,
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
            Text('ProgressData: ${_progressData[widget.index]}'),
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
