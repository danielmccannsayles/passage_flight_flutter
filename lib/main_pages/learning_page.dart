import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_theme.dart';

import 'package:pdfx/pdfx.dart';
import 'dart:developer';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  State<LearningPage> createState() => LearningPageState();
}

class PdfFile {
  String filePath;
  String title;
  String blurb;
  late final document = PdfDocument.openAsset(filePath);

  PdfFile(this.filePath, this.title, this.blurb);
}

class AdventureObject {
  String title;
  String blurb;
  String filePath;

  AdventureObject(this.title, this.blurb, this.filePath);
}

//global controller. Reassign controller when things change.
PdfController pdfController = PdfController(
    document: PdfDocument.openAsset('assets/lessonPdfs/lesson2.pdf'));

createController(document) {
  pdfController.loadDocument(document);
  return pdfController;
}

class LearningPageState extends State<LearningPage> {
  final _lessonsList = <PdfFile>[
    PdfFile('assets/lessonPdfs/learning1.pdf', 'Lesson 1 (Short)',
        'This lesson covers the filter'),
    PdfFile('assets/lessonPdfs/lesson2.pdf', 'Lesson 2 (Full length)',
        'This lesson covers water'),
    PdfFile('assets/lessonPdfs/lesson3.pdf', 'Lesson 3 (Full length)',
        'This lesson covers gravity and physics'),
  ];

  final _adventuresList = <AdventureObject>[
    AdventureObject('Science 1', 'This is science one', '/scienceLessonOne')
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(children: [
              Row(
                children: const [
                  Text('Lessons'),
                  SizedBox(width: 500),
                  Text('Adventures')
                ],
              ),
              Expanded(
                child: Row(children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _lessonsList.length,
                        // The list items
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            color: AppTheme.colors.orange,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  //willpopscope is used cause popping this page crashes the app - something to fix
                                  return WillPopScope(
                                      onWillPop: () async => false,
                                      child: Scaffold(
                                          appBar: pdfBar(
                                            context,
                                            _lessonsList[index].title,
                                          ),
                                          body: PdfView(
                                              controller: PdfController(
                                                  document: _lessonsList[index]
                                                      .document))));
                                }));
                              },
                              title: Text(
                                _lessonsList[index].title,
                                style: const TextStyle(fontSize: 24),
                              ),
                              subtitle: Text(
                                _lessonsList[index].blurb,
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _adventuresList.length,
                        // The list items
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            color: AppTheme.colors.orange,
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, _adventuresList[index].filePath);
                              },
                              title: Text(
                                _adventuresList[index].title,
                                style: const TextStyle(fontSize: 24),
                              ),
                              subtitle: Text(
                                _adventuresList[index].blurb,
                              ),
                            ),
                          );
                        }),
                  ),
                ]),
              )
            ])));
  }
}

AppBar pdfBar(context, String title) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: 40,
      color: AppTheme.colors.darkBlue,
      onPressed: () {
        log('test');
        pdfController.dispose();
        //if pop until is used then it tries to pop the pdf page which is a poroblem.
        //I think it's cause it disposes of the pdf viewer
        //Either way just have it push the home page instead of popping until.
        Navigator.pushNamed(context, '/', arguments: 2);
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    ),
    centerTitle: true,
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    backgroundColor: AppTheme.colors.lightBlue,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    toolbarHeight: 50,
  );
}
