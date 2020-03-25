import 'package:flutter/material.dart';

/*
Created NB 3/21/2020

This Provider class stores information for the Settings (settings.dart) class
The first 3 widgets on the settings page are just examples and don't change anything else,
but they are able to store if those selections even if the app in closed or turned off
 */
class WikiArticleListProvider with ChangeNotifier {
  List<String> _summaryList;
  List<String> _articleTitleList;
  List<dynamic> _distanceList;
  List<dynamic> _latitudeList;
  List<dynamic> _longitudeList;
  List<String> _imageUrlList;

  List<String> get summaryList => _summaryList;
  List<String> get articleTitleList => _articleTitleList;
  List<dynamic> get distanceList => _distanceList;
  List<dynamic> get latitudeList => _latitudeList;
  List<dynamic> get longitudeList => _longitudeList;
  List<String> get imageUrlList => _imageUrlList;

  WikiArticleListProvider() {
    _summaryList = [
      'Summary Example 1',
      'Summary Example 2',
      'Summary Example 3',
      'Summary Example 4'
    ];

    _articleTitleList = [
      'Title Example 1',
      'Title Example 2',
      'Title Example 3',
      'Title Example 4'
    ];

    _distanceList = [1.0000, 2.0000, 3.0000, 4.000000];

    _latitudeList = [1.0000, 2.0000, 3.0000, 4.000000];

    _longitudeList = [1.0000, 2.0000, 3.0000, 4.000000];

    _imageUrlList = [
      'https://upload.wikimedia.org/wikipedia/commons/1/1b/Carner.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/9/9c/Craver_farmstead_2014.png',
      'https://upload.wikimedia.org/wikipedia/commons/1/1b/Carner.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/9/9c/Craver_farmstead_2014.png',
    ];
  }
}
