import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;



class MapProvider with ChangeNotifier{
  double _latValue;
  double _lonValue;
  Set<Marker> _newsetOfMarkers;
  CameraPosition _kGooglePlex;
  Completer<GoogleMapController> _controller;
  String _title;
  int _pageId;
  int _resultsLength;
  List<int> _pageIdList;
  List<String> _titleList;
  Marker _homeMarker;
  List<double> _mapDistanceList;
  List<double> _mapLatitudeList;
  List<double> _mapLongitudeList;


  double get latValue => _latValue;
  double get lonValue => _lonValue;
  Set<Marker> get setOfMarkers => _newsetOfMarkers;
  CameraPosition get kGooglePlex => _kGooglePlex;
  Completer<GoogleMapController> get controller => _controller;
  String get title => _title; //this is used to send the title to the wiki article provider
  int get pageId => _pageId;
  int get resultsLength => _resultsLength;
  List<int> get pageIdList => _pageIdList;
  List<String> get titleList => _titleList;
  Marker get homeMarker => _homeMarker;
  List<double> get mapDistanceList => _mapDistanceList;
  List<double> get mapLatitudeList => _mapLatitudeList;
  List<double> get mapLongitudeList => _mapLongitudeList;

  String wikiUrlStart = Uri.encodeFull("https://en.wikipedia.org/w/api.php?" + "action=query&list=geosearch&gscoord=" + "42.730936" + "|" + " -73.761912" + "&gsradius=10000&gslimit=10&format=json");//&callback=?");
  String wikiSummaryUrl = Uri.encodeFull("https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=");
  Map<String, String> headers = {
    "Accept": "text/plain"
  };

  MapProvider() {
    _kGooglePlex = CameraPosition(
        target: LatLng(42.730936, -73.761912),
        zoom: 13//14.4746,
    );
    _controller = Completer();
    getMarkers();
  }

  void setMapLongitudeList(List<double> mapLongitudeList) {
    _mapLongitudeList = mapLongitudeList;
    notifyListeners();
  }

  void setMapLatitudeList(List<double> mapLatitudeList) {
    _mapLatitudeList = mapLatitudeList;
    notifyListeners();
  }

  void setMapDistanceList(List<double> mapDistanceList) {
    _mapDistanceList = mapDistanceList;
    notifyListeners();
  }

  void setHomeMarker(Marker homeMarker) {
    _homeMarker = homeMarker;
    notifyListeners();
  }

  void setLatValue(double latValue) {
    _latValue = latValue;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setPageId(int pageId) {
    _pageId = pageId;
    notifyListeners();
  }

  void setLonValue(double lonValue) {
    _lonValue = lonValue;
    notifyListeners();
  }

  void setMarkerSet(Set<Marker> setOfMarkers) {
    _newsetOfMarkers = setOfMarkers;
    notifyListeners();
  }

  void setPageIdList(List<int> pageIdList) {
    _pageIdList = pageIdList;
    notifyListeners();
  }

  void setTitleList(List<String> titleList) {
    _titleList = titleList;
    notifyListeners();
  }

  Future<String> getSummary(String title, int pageID) async {
    print('START OF SUMMARY');
    print(title);
    print(pageID);
    var sumResponse = await http.get(
        wikiSummaryUrl + Uri.encodeFull(title),
        headers: headers
    );
    String jsonSummaryString = sumResponse.body.toString();
    var _sumData = json.jsonDecode(jsonSummaryString);
    var sumString = _sumData['query']['pages'][Uri.encodeFull(pageID.toString())]['extract'];//[pageID]['extract'];
    print('SUMMARY PRINT OUT');
    print(sumString);
    return sumString;
  }

  getMarkers() async {
    List<Marker> _markers = List<Marker>();
    Marker _tempHomeMarker = Marker(
        markerId: MarkerId('0'),
        icon: BitmapDescriptor.defaultMarkerWithHue(50),
        position: LatLng(42.748236, -73.839402),
        infoWindow: InfoWindow(
            title: 'STARTING POINT'
        )
    );
    _markers.add(_tempHomeMarker);

    var response = await http.get(
        wikiUrlStart,
        headers: headers
    );
    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = json.jsonDecode(jsonsDataString);
    if(!_data["query"]["geosearch"].isEmpty) {
      setLatValue(_data["query"]["geosearch"][0]["lat"]);
      setLonValue(_data["query"]["geosearch"][0]["lon"]);
      setTitle(_data["query"]["geosearch"][0]["title"]);
      setPageId(_data["query"]["geosearch"][0]["pageid"]);
      List<int> _tempPageIdList = List<int>();
      List<String> _tempTitleList = List<String>();
      List<double> _tempMapDistanceList = List<double>();
      List<double> _tempMapLatitudeList = List<double>();
      List<double> _tempMapLongitudeList = List<double>();
      Marker _myMarker;
      int i = 0;
      for (var prop in _data['query']['geosearch']) {
        _myMarker = Marker(
            markerId: MarkerId(prop.hashCode.toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(100),
            position: LatLng(_data['query']['geosearch'][i]['lat'],
                _data['query']['geosearch'][i]['lon']),
            infoWindow: InfoWindow(
                title: _data['query']['geosearch'][i]['title']
            )
        );
        _markers.add(_myMarker);
        _tempPageIdList.add(_data['query']['geosearch'][i]['pageid']);
        _tempTitleList.add(_data['query']['geosearch'][i]['title']);
        _tempMapDistanceList.add(_data['query']['geosearch'][i]['dist']);
        _tempMapLatitudeList.add(_data['query']['geosearch'][i]['lat']);
        _tempMapLongitudeList.add(_data['query']['geosearch'][i]['lon']);
        i++;
      }
      Set<Marker> _setOfMarkers = Set.of(_markers);
      setMapLatitudeList(_tempMapLatitudeList);
      setMapLongitudeList(_tempMapLongitudeList);
      setPageIdList(_tempPageIdList);
      setTitleList(_tempTitleList);
      setMapDistanceList(_tempMapDistanceList);
      setMarkerSet(_setOfMarkers);
    } else {
      Set<Marker> _setOfMarkers = Set.of(_markers);
      setMarkerSet(_setOfMarkers);
      //TODO add more exception cases
    }
  }
}
