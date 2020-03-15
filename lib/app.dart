import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/pages/home.dart';
import 'package:wiki_map/providers/settings_provider.dart';
import 'package:wiki_map/providers/theme_provider.dart';
import 'package:wiki_map/style.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => SettingsProvider(themeProvider),
      child: MaterialApp(
        title: 'Wax App',
        theme: themeProvider.themeData,
        home: Home(),
      ),
    );
  }
}

