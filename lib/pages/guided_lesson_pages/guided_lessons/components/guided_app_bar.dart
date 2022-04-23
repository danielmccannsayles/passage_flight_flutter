import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:passage_flutter/theme/app_theme.dart';

AppBar guidedAppBar(
    context,
    String title,
    double progressValue,
    ScrollController controller,
    int progressVisual,
    void Function() clearProgress) {
  return AppBar(
    leadingWidth: 260,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: 40,
      color: AppTheme.colors.darkBlue,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    bottom: PreferredSize(
        child: LinearProgressIndicator(
          value: progressVisual / 100,
        ),
        preferredSize: const Size(10, 10)),

    actions: <Widget>[
      Text('Progress: $progressVisual%',
          style: const TextStyle(color: Colors.black)),
      TextButton(
        onPressed: () {
          controller
              .animateTo(0.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn)
              .then((_) {
            clearProgress();
          });
        },
        child: const Text('Reset Progress'),
      ),
      TextButton(
        onPressed: () {
          controller.animateTo(progressValue,
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn);
        },
        child: const Text('Current Progress'),
      ),
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
