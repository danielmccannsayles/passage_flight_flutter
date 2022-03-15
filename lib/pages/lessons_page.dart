import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import '../components/custom_app_bar.dart';

import 'package:pdfx/pdfx.dart';
import 'dart:developer';

class LessonsPage extends StatefulWidget {
  const LessonsPage({Key? key}) : super(key: key);

  @override
  State<LessonsPage> createState() => LessonsPageState();
}

class PdfFile {
  String filepath;
  String title;
  String blurb;
  late final document = PdfDocument.openAsset(filepath);

  PdfFile(this.filepath, this.title, this.blurb);
}

//global controller. Reassign controller when things change.
PdfController pdfController = PdfController(
    document: PdfDocument.openAsset('assets/lessonPdfs/lesson2.pdf'));

createController(document) {
  pdfController.loadDocument(document);
  return pdfController;
}

class LessonsPageState extends State<LessonsPage> {
  final _lessonsList = <PdfFile>[
    PdfFile('assets/lessonPdfs/lesson2.pdf', 'Lesson 2',
        'This lesson covers water and other stuff'),
    PdfFile('assets/lessonPdfs/lesson3.pdf', 'Lesson 3',
        'This lesson covers gravity and physics'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Lessons'),
      body: Column(children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Go Home'),
            ),
          ],
        ),
        Center(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _lessonsList.length,
                // The list items
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Colors.amberAccent,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Scaffold(
                              appBar: pdfBar(
                                context,
                                _lessonsList[index].title,
                              ),
                              body: PdfView(
                                  controller: PdfController(
                                      document: _lessonsList[index].document)));
                        }));
                      },
                      title: Text(
                        _lessonsList[index].title,
                        style: const TextStyle(fontSize: 24),
                      ),
                      trailing: Text(
                        _lessonsList[index].blurb,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                }))
      ]),
    );
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
        //if pop until is used then it tries to pop the pdf page which is a poroblem.
        //I think it's cause it disposes of the pdf viewer
        //Either way just have it push the home page instead of popping until.
        Navigator.pushNamed(context, '/');
        Navigator.pushNamed(context, '/lessonsPage');
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
