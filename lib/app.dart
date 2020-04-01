import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/pages/home.dart';
import 'package:wiki_map/providers/saved_pages_provider.dart';
import 'package:wiki_map/providers/settings_provider.dart';
import 'package:wiki_map/providers/theme_provider.dart';
import 'package:wiki_map/providers/user_input_provider.dart';
import 'package:wiki_map/services/geolocator_service.dart';
//import 'package:wiki_map/style.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final GeoLocatorService geoService = GeoLocatorService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
            create: (_) => SettingsProvider(themeProvider)),
        ChangeNotifierProvider<UserInputProvider>(
            create: (_) => UserInputProvider()),
        ChangeNotifierProvider<SavedPagesProvider>(
            create: (_) => SavedPagesProvider()),
        FutureProvider(create: (context) => geoService.getCoords()),
        ProxyProvider<Position, Future<List<Placemark>>>(
          update: (context, position, placemarks) =>
              (position != null) ? geoService.getAddress(position) : null,
        )

        // ChangeNotifierProvider<WikiArticleListProvider>(
        //     create: (_) => WikiArticleListProvider())
      ],
      child: MaterialApp(
        title: 'Wax App',
        theme: themeProvider.themeData,
        home: Home(),
      ),
    );
  }
}
