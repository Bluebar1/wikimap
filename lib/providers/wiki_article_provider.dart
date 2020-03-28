import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'map_provider.dart';

/*

Created NB 3/21/2020

This class stores the data and logic for displaying the list of Wikipedia pages-
and is launched from the GeoSearch (geosearch.dart) widget when the "show wiki pages" button is pressed.
This is a class 'with ChangeNotifier' which means it can communicate with it's own listeners-
within the main widget tree.
This class needs to use coordinate information provided by the MapProvider (map_provider.dart) class,
so I pass a MapProvider object in the constructor to be able to access its information in order to
request and load new information from wikipedia such as summary, pictures, etc...

*/
class WikiArticleProvider with ChangeNotifier {
  //Member variables needed
  List<String> _summaryList;
  List<String> _articleTitleList;
  List<dynamic> _distanceList;
  List<dynamic> _latitudeList;
  List<dynamic> _longitudeList;
  List<String> _imageUrlList;
  List<int> _pageIdList;

  //getter methods for accessing in widget tree
  List<String> get summaryList => _summaryList;
  List<String> get articleTitleList => _articleTitleList;
  List<dynamic> get distanceList => _distanceList;
  List<dynamic> get latitudeList => _latitudeList;
  List<dynamic> get longitudeList => _longitudeList;
  List<String> get imageUrlList => _imageUrlList;
  List<int> get pageIdList => _pageIdList;

  //links for http get requests
  String wikiSummaryUrl = Uri.encodeFull(
      "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=");
  String wikiImageListUrl = Uri.encodeFull(
      "https://en.wikipedia.org/w/api.php?action=query&titles="); //Graffiti_000&ailimit=3")
  String noImageFound = Uri.encodeFull(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Apple_Garage.jpg/1280px-Apple_Garage.jpg"); //Graffiti_000&ailimit=3")
  //header for http requests
  Map<String, String> headers = {"Accept": "text/plain"};

  //class constructor, takes MapProvider as parameter because it contains information needed in this class
  WikiArticleProvider(MapProvider provider) {
    print('WIKI PROVIDER CALLED');
    _summaryList = null;
    _imageUrlList = null;
    _latitudeList = provider.mapLatitudeList;
    _longitudeList = provider.mapLongitudeList;
    _pageIdList = provider.pageIdList;
    print('SUMMARY LIST PRINTOUT FROM CONSTRUCTOR ' + _summaryList.toString());
    getAndSetWikiInfo(provider);
  }

  //this function is used to ensure that the member variables are set at one time
  //there is a Consumer<WikiArticleProvider> listener in the geosearch.dart file
  //that waits for this to complete before trying to display the data
  //TODO check if I even need this, can't I just wait for them in the consumer with an if(x==null || y==null) statement?
  getAndSetWikiInfo(MapProvider provider) async {
    return Future.wait([getWikiImageUrls(provider), getWikiSummary(provider)])
        .then((value) {
      print(
          "===============SET VALUE HERE ====================================");
      print(value);
      setImageUrlList(value[0]);
      setSummaryList(value[1]);
    }).catchError((error) => _handleError(error));
  }

  //helper function for displaying errors from the above function
  _handleError(var err) {
    print("HANDLE VALUE CALLL RIGHT HERE--------------------------");
    print(err);
    print(err.runtimeType);
  }

  //member variable set functions, notifiers listeners in widget tree when changed.
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

  //Fetched a List of image URLs with information from MapProvider.
  //Stores Links as a string, and checks if the type of file (.jpg, .jpeg, .svg, .png, etc...)
  //If the type of image file causes an error, a link to a blank grey background is added to the list
  Future<List<String>> getWikiImageUrls(MapProvider provider) async {
    print(
        '======================GETWIKIIMAGEURL CALLED ================================');
    List<String> _tempImageUrlString = List<String>();
    int i = 0;
    for (String str in provider.titleList) {
      print(str); //prints title in console as it is being requested
      var imageResponse = await http.get(
          //http get request for the first image in the list
          wikiImageListUrl +
              Uri.encodeFull(str) +
              Uri.encodeFull('&prop=pageimages&piprop=original&format=json'),
          headers: headers);
      String jsonImageDataString =
          imageResponse.body.toString(); //convert the response to a string
      var _imgData =
          json.jsonDecode(jsonImageDataString); //convert to json variable
      if (_imgData['query']['pages'][provider.pageIdList[i].toString()]
              .length ==
          4) {
        //Uses pageIdList variable from MapProvider to check if that page has an image
        var _tempImgUrl = _imgData['query']['pages']
                [provider.pageIdList[i].toString()]['original'][
            'source']; //if it has an image ( .length == 4 ) then store link in a var
        String _full = _tempImgUrl
            .toString(); //substring conversions to check the ending will cause an error
        String _endString = _full.substring((_full.length) - 4, _full.length);
        if (_endString.contains('svg')) {
          //svg causes an error in the app, so a link to a blank background is added to the list instead
          _tempImageUrlString.add(
              'https://www.solidbackgrounds.com/images/2560x1440/2560x1440-davys-grey-solid-color-background.jpg');
        } else {
          _tempImageUrlString.add(_tempImgUrl);
        }
      } else {
        //if the contains no images ( .length is not 4 ) then add a blank background to the list
        _tempImageUrlString.add(
            'https://www.solidbackgrounds.com/images/2560x1440/2560x1440-davys-grey-solid-color-background.jpg');
      }
      i++;
    }
    return _tempImageUrlString;
  }

  Future<List<String>> getWikiSummary(MapProvider provider) async {
    print('========================SUMMARY CALLED =========================');
    List<String> _tempList = List<String>(); //temporary summary list
    List<String> _tempTitleList = List<String>(); //temporary title list
    List<dynamic> _tempDistanceList = List<dynamic>(); //temporary distance list
    int i = 0; //keep track of index for pageIdList
    //int j starts at 1 because the first marker in the provider.setOfMarkers[0] is not a wikipedia page, it is the starting location of the search
    for (int j = 1; j < provider.setOfMarkers.length; j++) {
      var sumResponse = await http.get(
          //http get request
          wikiSummaryUrl + Uri.encodeFull(provider.titleList[i]),
          headers: headers);
      String jsonSummaryString =
          sumResponse.body.toString(); //convert response body to string
      var _sumData =
          json.jsonDecode(jsonSummaryString); //convert to json variable
      //store wiki information from http wiki json in variables
      var sumString = _sumData['query']['pages']
          [Uri.encodeFull(provider.pageIdList[i].toString())]['extract'];
      var titleString = _sumData['query']['pages']
          [Uri.encodeFull(provider.pageIdList[i].toString())]['title'];
      var distDouble = provider.mapDistanceList[i];
      //add those variables to the temporary lists and increment i++
      _tempList.add(sumString);
      _tempTitleList.add(titleString);
      _tempDistanceList.add(distDouble);
      i++;
    }
    //set distance and title list
    setDistanceList(_tempDistanceList);
    setArticleTitleList(_tempTitleList);
    //return the summary list because Future.wait is waiting for it to complete in the getAndSetWikiInfo function
    return _tempList;
  }
}
