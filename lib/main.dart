import 'package:flutter/material.dart';
import 'package:passage_flutter/filter_components/background_collected_page.dart';
import 'package:passage_flutter/pages/lessons_page.dart';

import 'package:passage_flutter/pages/profile.dart';
import 'package:passage_flutter/pages/settings.dart';
import 'package:passage_flutter/pages/filter.dart';
import 'package:passage_flutter/pages/manuals.dart';
import 'package:passage_flutter/pages/pdf_viewer_page.dart';

import 'package:passage_flutter/theme/app_theme.dart';
import '/components/custom_app_bar.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//Every time pub get is run, implicilty or explicitly, the IDE thinks this package doesn't exist. Very annoying.

import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.=

  Locale _locale = const Locale.fromSubtags(languageCode: 'en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/profile': (context) => const Profile(),
        '/settings': (context) => const Settings(),
        '/manualsHome': (context) => const ManualsHome(),
        '/filtersHome': (context) => const FiltersHome(),
        '/lessonsPage': (context) => const LessonsPage(),
        '/pdfViewer': (context) => const PDFViewerPage(),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      locale: _locale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: customAppBar(context, 'HomePage'),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppTheme.colors.darkBlue),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/filtersHome');
              },
              child: Text(
                AppLocalizations.of(context)!.filter,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppTheme.colors.orange),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/manualsHome');
              },
              child: Text(
                AppLocalizations.of(context)!.manual,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/lessonsPage');
              },
              child: const Text(
                'Lessons',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherPage extends StatelessWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
