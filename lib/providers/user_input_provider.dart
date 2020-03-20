import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class UserInputProvider with ChangeNotifier{
  CameraPosition _startingLocation;
  TextEditingController _latitudeController;
  TextEditingController _longitudeController;
  double _inputLatitude;
  double _inputLongitude;

  CameraPosition get startingLocation => _startingLocation;
  TextEditingController get latitudeController => _latitudeController;
  TextEditingController get longitudeController => _longitudeController;
  double get inputLatitude => _inputLatitude;
  double get inputLongitude => _inputLongitude;

  UserInputProvider() {
    print('===========================USER INPUT PROVIDER CONSTRUCTOR CALLED==============================');
    _longitudeController = TextEditingController();
    _latitudeController = TextEditingController();
  }

  void setStartingLocation(double inputLatitude, double inputLongitude) {
    print('===========================SET STARTING LOCATION METHOD CALLED==============================');

    _startingLocation = CameraPosition(
      target: LatLng(inputLatitude, inputLongitude),
      zoom: 13
    );
  }

  void setInputLatitude(double inputLatitude) {
    print('SETINPUTLATITUDE CALLED ' + inputLatitude.toString());
    _inputLatitude = inputLatitude;
    notifyListeners();
  }

  void setInputLongitude(double inputLongitude) {
    print('SETINPUTLONGITUDE CALLED ' + inputLongitude.toString());
    _inputLongitude = inputLongitude;
    notifyListeners();
  }

  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

}