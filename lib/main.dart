import 'package:flutter/material.dart';
import 'package:passage_flutter/pages/guided_lesson_pages/guided_lessons/science_lesson.dart';
import 'package:passage_flutter/pages/lessons_page.dart';

import 'package:passage_flutter/pages/profile.dart';
import 'package:passage_flutter/pages/settings.dart';
import 'package:passage_flutter/pages/filter.dart';
import 'package:passage_flutter/pages/manuals.dart';

import 'package:passage_flutter/theme/app_theme.dart';
import '/components/custom_app_bar.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//Every time pub get is run, implicilty or explicitly, the IDE thinks this package doesn't exist. Very annoying.

import 'package:provider/provider.dart';

import 'pages/guided_lesson_pages/progress_model.dart';
import 'pages/guided_lesson_pages/guided_lessons.dart';

import 'package:flutter/services.dart';
import './components/tita_text_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'dart:developer';

void main() {
  // Call this manually before setpreferred orientation
  WidgetsFlutterBinding.ensureInitialized();

  //set preferred orientation then run app
  //Documentation: https://greymag.medium.com/flutter-orientation-lock-portrait-only-c98910ebd769
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale.fromSubtags(languageCode: 'en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LIFE APP',
      initialRoute: '/',
      routes: {
        '/': (context) => ChangeNotifierProvider(
              create: (context) => ProgressStore(),
              child: const MyHomePage(),
            ),
        '/profile': (context) => const Profile(),
        '/settings': (context) => const Settings(),
        '/manualsHome': (context) => const ManualsHome(),
        '/filtersHome': (context) => const FiltersHome(),
        //lessons page has active state which is the progress.
        '/lessonsPage': (context) => const LessonsPage(),
        '/guidedLessons': (context) => ChangeNotifierProvider(
              create: (context) => ProgressStore(),
              child: const GuidedLessons(),
            ),
        '/scienceLessonOne': (context) => ChangeNotifierProvider(
              create: (context) => ProgressStore(),
              child: const ScienceLesson(),
            ),
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
  //initialized at 1 to start on the 'home' screen

  int _selectedIndex = 1;

  bool _firstUpdate = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _firstUpdate = false;
    });
  }

  static final List<Widget> _pages = <Widget>[
    const LessonsPage(),
    Home(),
    const FiltersHome()
  ];

  @override
  Widget build(BuildContext context) {
    //only done on first update - used to push argument to named path so that you can
    //navigate to one of the pages
    //ONLY NEEDED WHEN PUSHING NEW NAMED ROUTE - obsolete now, was used to get around pdf
    //viewer problem
    if (_firstUpdate) {
      int _startingIndex = ModalRoute.of(context)?.settings.arguments != null
          ? ModalRoute.of(context)?.settings.arguments as int
          : _selectedIndex;

      setState(() {
        _selectedIndex = _startingIndex;
      });
      _firstUpdate = false;
    }

    return Scaffold(
        appBar: customAppBar(context, 'LIFE'),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 250, right: 250, bottom: 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppTheme.colors.buttonBlue, width: 2),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BottomNavyBar(
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                    icon: const Icon(Icons.local_library),
                    title: const Text('Learn'),
                    activeColor: AppTheme.colors.buttonBlue,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(Icons.house),
                    title: const Text('Home'),
                    activeColor: AppTheme.colors.buttonBlue,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(Icons.water_drop),
                    title: const Text('Filter'),
                    activeColor: AppTheme.colors.buttonBlue,
                  ),
                ],
                selectedIndex: _selectedIndex, //New
                onItemSelected: _onItemTapped,
              ),
            ),
          ),
        ),
        body: _pages[_selectedIndex]);
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final double _height = 150;

  final double _width = 200;

  late TabController _myTabController;

  void initState() {
    super.initState();
    _myTabController = TabController(vsync: this, initialIndex: 0, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // flexibleSpace: ColoredBox(
            //   color: AppTheme.colors.buttonBlue,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       TabBar(
            //         labelColor: Colors.white,
            //         indicatorColor: Colors.white,
            //         controller: _myTabController,
            //         tabs: const [
            //           Tab(
            //             text: 'Meet the Students',
            //           ),
            //           Tab(
            //             text: 'Why a Filter?',
            //           ),
            //           Tab(
            //             text: 'What we hope for you',
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            ),
        body: // TabBarView(
            //controller: _myTabController,
            //children: const [
            MeetTheStudents()
        // Text('under construction'),
        //  Text('under construction'),
        // ],
        // ),
        );
  }
}

class MeetTheStudents extends StatelessWidget {
  const MeetTheStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 40, right: 40, top: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            const Text(
                'Hi, Welcome to your L.I.F.E. tablet & accompanying water filter! You\'re currently on the home page. Click on the buttons down below to go to the filter on the right, and the learning lessons, on the left.',
                style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 100,
            ),
            TitaTextBar(
                length: 1,
                happyBool: true,
                text:
                    'LIFE stands for LATAM Filter for Education and is a university project made by 5 engineering and 4 public health students! ')
          ],
        ));
  }
}
