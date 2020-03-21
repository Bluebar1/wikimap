import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'map_provider.dart';







class WikiArticleProvider with ChangeNotifier {
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

  String wikiSummaryUrl = Uri.encodeFull("https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=");
  String wikiImageListUrl = Uri.encodeFull("https://en.wikipedia.org/w/api.php?action=query&titles=");//Graffiti_000&ailimit=3")
  String noImageFound = Uri.encodeFull("https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Apple_Garage.jpg/1280px-Apple_Garage.jpg");//Graffiti_000&ailimit=3")

  Map<String, String> headers = {
    "Accept": "text/plain"
  };

  WikiArticleProvider(MapProvider provider) {
    print('WIKI PROVIDER CALLED');
    _summaryList = null;
    _imageUrlList = null;
    _latitudeList = provider.mapLatitudeList;
    _longitudeList = provider.mapLongitudeList;
    print('SUMMARY LIST PRINTOUT FROM CONSTRUCTOR ' + _summaryList.toString());
    getAndSetWikiInfo(provider);
    //getWikiImageUrls(provider);
    //getWikiSummary(provider);
  }

  getAndSetWikiInfo(MapProvider provider) async {
    return Future.wait([getWikiImageUrls(provider), getWikiSummary(provider)]).then((value) {
      print("===============SET VALUE HERE ====================================");
      print(value);
      setImageUrlList(value[0]);
      setSummaryList(value[1]);
    }).catchError((error) => _handleError(error));
  }

  _handleError(var err) {
    print("HANDLE VALUE CALLL RIGHT HERE--------------------------");
    print(err);
    print(err.runtimeType);
  }

  void setImageUrlList(List<String> imageUrlList) {
    _imageUrlList = imageUrlList;
    notifyListeners();
  }

  void setLongitudeList(List<dynamic> longitudeList) {
    _longitudeList = longitudeList;
    notifyListeners();
  }

  void setLatitudeList(List<dynamic> latitudeList) {
    _latitudeList = latitudeList;
    notifyListeners();
  }

  void setDistanceList(List<dynamic> distanceList) {
    _distanceList = distanceList;
    notifyListeners();
  }

  void setArticleTitleList(List<String> articleTitleList) {
    _articleTitleList = articleTitleList;
    notifyListeners();
  }

  void setSummaryList(List<String> summaryList) {
    _summaryList = summaryList;
    notifyListeners();
  }

  Future<List<String>> getWikiImageUrls(MapProvider provider) async {
    print('GETWIKIIMAGEURL CALLED ================================');
    print('State of Class List: ' + _imageUrlList.toString());
    List<String> _tempImageUrlString = List<String>();
    int i = 0;
    for(String str in provider.titleList) {
      print(str);
      var imageResponse = await http.get(
          wikiImageListUrl + Uri.encodeFull(str) + Uri.encodeFull('&prop=pageimages&piprop=original&format=json'),
          headers: headers
      );
      String jsonImageDataString = imageResponse.body.toString();
      var _imgData = json.jsonDecode(jsonImageDataString);
      if(_imgData['query']['pages'][provider.pageIdList[i].toString()].length == 4) {
        var _tempImgUrl = _imgData['query']['pages'][provider
            .pageIdList[i].toString()]['original']['source'];
        String _full = _tempImgUrl.toString();
        String _endString = _full.substring((_full.length)-4, _full.length);
        if(_endString.contains('svg')) {
          _tempImageUrlString.add('https://www.solidbackgrounds.com/images/2560x1440/2560x1440-davys-grey-solid-color-background.jpg');
        } else{
          _tempImageUrlString.add(_tempImgUrl);
        }
      } else {
        _tempImageUrlString.add('https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Apple_Garage.jpg/1280px-Apple_Garage.jpg');
      }
      i++;
    }
    print('Set Image About to be called with value: ' + _tempImageUrlString.toString());
    //setImageUrlList(_tempImageUrlString);
    return _tempImageUrlString;
  }

  Future<List<String>> getWikiSummary(MapProvider provider) async {
    print('SUMMARY CALLED =========================with value of: ' + _summaryList.toString());

    List<String> _tempList = List<String>();
    List<String> _tempTitleList = List<String>();
    List<dynamic> _tempDistanceList = List<dynamic>();
    int i = 0;
    for(int j = 1; j < provider.setOfMarkers.length; j++) {
      var sumResponse = await http.get(
          wikiSummaryUrl + Uri.encodeFull(provider.titleList[i]),
          headers: headers
      );
      String jsonSummaryString = sumResponse.body.toString();
      var _sumData = json.jsonDecode(jsonSummaryString);
      var sumString = _sumData['query']['pages'][Uri.encodeFull(provider.pageIdList[i].toString())]['extract'];
      var titleString = _sumData['query']['pages'][Uri.encodeFull(provider.pageIdList[i].toString())]['title'];
      var distDouble = provider.mapDistanceList[i];
      _tempList.add(sumString);
      _tempTitleList.add(titleString);
      _tempDistanceList.add(distDouble);
      i++;
    }
    setDistanceList(_tempDistanceList);
    print('SUMMARY FINISHED =========================with value of: ' + _tempList.toString());
    setArticleTitleList(_tempTitleList);
    //setSummaryList(_tempList);

    print('SUMMARY SET =========================AND IS NOW VALUE: ' + _summaryList.toString());
    return _tempList;
  }

}
