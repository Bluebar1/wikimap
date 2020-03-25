import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wiki_map/providers/wiki_article_provider.dart';
import 'dart:convert' as json;
import 'map_provider.dart';

/*

Created NB 3/25/2020



*/
class SelectWikiPageProvider with ChangeNotifier {
  //Member variables needed
  String _summary;
  String _articleTitle;
  String _imageUrl;
  dynamic _distance;
  dynamic _latitude;
  dynamic _longitude;
  int _index;

  //getter methods for accessing in widget tree
  String get summary => _summary;
  String get articleTitle => _articleTitle;
  String get imageUrl => _imageUrl;
  dynamic get distance => _distance;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  int get index => _index;

  //class constructor, takes MapProvider as parameter because it contains information needed in this class
  SelectWikiPageProvider(WikiArticleProvider provider, int index) {
    _summary = null;
    _articleTitle = null;
    _imageUrl = null;
    _distance = null;
    _latitude = null;
    _longitude = null;
    _index = index;
    setPageData(provider, index);
  }

  void setPageData(WikiArticleProvider provider, int index) {
    setSummary(provider.summaryList[index]);
    setArticleTitle(provider.articleTitleList[index]);
    setDistance(provider.distanceList[index]);
    setLatitude(provider.latitudeList[index]);
    setImageUrl(provider.imageUrlList[index]);
    setLongitude(provider.latitudeList[index]);
  }

  void setLongitude(dynamic longitude) {
    _longitude = longitude;
    notifyListeners();
  }

  void setLatitude(dynamic latitude) {
    _latitude = latitude;
    notifyListeners();
  }

  void setDistance(dynamic distance) {
    _distance = distance;
    notifyListeners();
  }

  void setArticleTitle(String articleTitle) {
    _articleTitle = articleTitle;
    notifyListeners();
  }

  void setSummary(String summary) {
    _summary = summary;
    notifyListeners();
  }

  void setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }
}
