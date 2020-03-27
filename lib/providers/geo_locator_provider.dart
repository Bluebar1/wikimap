import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorProvider with ChangeNotifier {
  Position _position;

  Position get position => _position;

  GeoLocatorProvider() {
    print('GEO LOCATOR PROVIDER CALLED');
    _position = null;
    getPosition();
  }

  void getPosition() async {
    Position tempPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setPosition(tempPosition);
  }

  void setPosition(Position position) {
    print('SET POSITION CALLED');
    print(position.toString());
    _position = position;
    notifyListeners();
  }
}
