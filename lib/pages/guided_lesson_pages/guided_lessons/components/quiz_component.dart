import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../progress_model.dart';

class QuizComponent extends StatefulWidget {
  final List questions;
  final List allAnswers;
  final List correctAnswers;
  final int numQuizzes;
  final int index;
  final int numQuestions;

  const QuizComponent(
      {Key? key,
      required this.questions,
      required this.allAnswers,
      required this.correctAnswers,
      required this.numQuizzes,
      required this.index,
      required this.numQuestions})
      : super(key: key);

  @override
  State<QuizComponent> createState() => _QuizComponentState();
}

class _QuizComponentState extends State<QuizComponent> {
  //internal state - initialized as a list of 'numQuizzes'  entries.
  late List<int> _quizData;

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
    // Provider.of<ProgressStore>(context, listen: false).changeTest('mathOne', 1);
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
      questions.add(Text(widget.allAnswers[i]));
    }
    return questions;
  }

  @override
  void initState() {
    super.initState();
    _quizData = List.filled(widget.numQuizzes, 0);
    _answeredQuestions = List.filled(widget.numQuestions, '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _storage = Provider.of<ProgressStore>(context);

    setState(() {
      //TODO:quizData = storage.getQuizArray
      _quizData[1] = _storage.getTestData()!.mathOne;
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children:
                    _createQuestions(), // <<<<< Note this change for the return type
              ),
            ),
            Text('${_quizData[1]}'),
            TextButton(
                onPressed: () {
                  Provider.of<ProgressStore>(context, listen: false)
                      .changeTest('mathOne', 1);
                },
                child: const Text('change to 1')),
            TextButton(
                onPressed: () {
                  Provider.of<ProgressStore>(context, listen: false)
                      .changeTest('mathOne', 2);
                },
                child: const Text('change to 2')),
          ],
        ));
  }
}
