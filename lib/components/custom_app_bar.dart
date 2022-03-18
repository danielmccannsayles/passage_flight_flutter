import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:passage_flutter/theme/app_theme.dart';

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
          // const SizedBox(
          //   width: 39,
          // ),
          // ToggleSwitch(
          //     initialLabelIndex: 1,
          //     totalSwitches: 2,
          //     labels: const ['English', 'Spanish'],
          //     onToggle: (index) {
          //       log('switched to: ' + index.toString());
          //       switch (index) {
          //         case 0:
          //           {
          //             MyApp.of(context)!.setLocale(
          //                 const Locale.fromSubtags(languageCode: 'en'));
          //           }
          //           break;
          //         case 1:
          //           {
          //             MyApp.of(context)!.setLocale(
          //                 const Locale.fromSubtags(languageCode: 'es'));
          //           }
          //           break;
          //       }
          //     }),
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
