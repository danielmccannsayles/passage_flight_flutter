import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';

class TeacherResources extends StatefulWidget {
  const TeacherResources({Key? key}) : super(key: key);

  @override
  State<TeacherResources> createState() => TeacherResourcesState();
}

class TeacherResourcesState extends State<TeacherResources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context, 'Teacher Resources'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const [
                  Text('Teacher Resources'),
                  Text('This will be the teacher resources')
                ],
              ))),
    );
  }
}
