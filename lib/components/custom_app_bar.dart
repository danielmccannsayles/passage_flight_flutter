import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:passage_flutter/theme/app_theme.dart';

import 'package:toggle_switch/toggle_switch.dart';

import 'package:passage_flutter/main.dart';

AppBar customAppBar(context, String title) {
  return AppBar(
    leadingWidth: 260,
    leading: Builder(
      builder: (BuildContext context) {
        return Row(children: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 50,
            color: AppTheme.colors.darkBlue,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
          const SizedBox(
            width: 39,
          ),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 2,
            labels: const ['English', 'Spanish'],
            onToggle: (index) {
              log('switched to: ' + index.toString());
              MyApp.of(context)!.setLocale(
                  Locale.fromSubtags(languageCode: index == 0 ? 'en' : 'es'));
            },
          ),
        ]);
      },
    ),
    // TODO(daniel): https://stackoverflow.com/questions/62717682/stack-multiple-icons-to-flutter-iconbutton

    actions: <Widget>[
      IconButton(
        icon: const Icon(MdiIcons.account),
        iconSize: 50,
        color: AppTheme.colors.darkBlue,
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    ],
    centerTitle: true,
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    backgroundColor: AppTheme.colors.lightBlue,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    toolbarHeight: 80,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0xffDDF5FF), // Status bar
    ),
  );
}
