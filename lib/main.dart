import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/providers/theme_provider.dart';
import 'package:wiki_map/style.dart';
import 'app.dart';

main() {
  runApp(
      ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: MyApp()));
}